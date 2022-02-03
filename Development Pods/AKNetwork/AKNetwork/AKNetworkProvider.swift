//
//  AKNetworkProvider.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Foundation
import Models
import Moya

public final class AKNetworkProvider<T: AKNetworkTargetType>: MoyaProvider<T> {

    // MARK: - Properties

    private let provider: MoyaProvider<T>
    private var requests = [String: Cancellable]()

    // MARK: - Init

    override public init(
        endpointClosure: @escaping MoyaProvider<T>.EndpointClosure = MoyaProvider<T>.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<T>.RequestClosure = MoyaProvider<T>.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<T>.StubClosure = MoyaProvider<T>.neverStub,
        callbackQueue: DispatchQueue? = nil,
        session: Session = defaultAlamofireSession(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        provider = MoyaProvider(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            callbackQueue: callbackQueue,
            session: session,
            plugins: [AKMoyaPlugin()],
            trackInflights: trackInflights
        )
    }

    // MARK: - Methods

    public func send(target: T, completion: @escaping (AKResult) -> Void) {
        print("Handle Request: \(target.baseURL)\(target.path)")
        let targetName = target.targetName
        requests[targetName]?.cancel()
        let request = provider.request(target) { [weak self] result in
            self?.requests[targetName] = nil
            switch result {
            case let .success(response):
                switch response.statusCode {
                case 200...299, 300...399:
                    self?.handleSuccess(data: response.data, completion: completion)
                case 401:
                    self?.handleAuthorizationError(completion: completion)
                default:
                    self?.handleError(data: response.data, completion: completion)
                }
            case let .failure(error):
                switch error.errorCode {
                case AKNetworkErrorCode.noInternetConnection.rawValue:
                    self?.handleInternetConnectionError(completion: completion)
                default:
                    self?.handleServerError(completion: completion)
                }
            }
        }
        guard target.isCancellable else { return }

        requests[targetName] = request
    }

    private func handleSuccess(data: Data, completion: @escaping (AKResult) -> Void) {
        guard let json = dataToJson(data: data) else {
            completion(.success(AKJSON()))
            return
        }

        completion(.success(json))
    }

    private func handleAuthorizationError(completion: @escaping (AKResult) -> Void) {
        completion(.failure(.authorizationError))
    }

    private func handleError(data: Data, completion: @escaping (AKResult) -> Void) {
        guard
            let json = dataToJson(data: data),
            let error = AKNetworkError(json: json)
        else {
            completion(.failure(.serverError))
            return
        }

        completion(.failure(error))
    }

    private func handleServerError(completion: @escaping (AKResult) -> Void) {
        completion(.failure(.serverError))
    }

    private func handleInternetConnectionError(completion: @escaping (AKResult) -> Void) {
        completion(.failure(.noInternetConnection))
    }

    private func dataToJson(data: Data) -> AKJSON? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            if let json = jsonObject as? AKJSON {
                return json
            } else if let json = jsonObject as? [AKJSON] {
                return [
                    "data": json
                ]
            } else if let json = jsonObject as? [Any] {
                return [
                    "data": json
                ]
            }
            return nil
        } catch {
            return nil
        }
    }

}


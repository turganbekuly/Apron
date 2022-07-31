//
//  CommunityCreationProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol CommunityCreationProviderProtocol {
    func createCommunity(
        request: CommunityCreationDataFlow.CreateCommunity.Request,
        compeletion: @escaping ((CommunityCreationDataFlow.CommunityCreationResult) -> Void)
    )

    func uploadImage(
        request: CommunityCreationDataFlow.UploadImage.Request,
        completion: @escaping ((CommunityCreationDataFlow.UploadImageResult) -> Void)
    )
}

final class CommunityCreationProvider: CommunityCreationProviderProtocol {

    // MARK: - Properties
    private let service: CommunityCreationServiceProtocol
    
    // MARK: - Init
    init(service: CommunityCreationServiceProtocol =
                    CommunityCreationService(provider: AKNetworkProvider<CommunityCreationEndpoint>())) {
        self.service = service
    }
    
    // MARK: - CommunityCreationProviderProtocol

    func createCommunity(
        request: CommunityCreationDataFlow.CreateCommunity.Request,
        compeletion: @escaping ((CommunityCreationDataFlow.CommunityCreationResult) -> Void)
    ) {
        service.createCommunity(request: request) {
            switch $0 {
            case let .success(json):
                if let community = CommunityResponse(json: json) {
                    compeletion(.successful(model: community))
                } else {
                    compeletion(.failed(error: .invalidData))
                }
            case let .failure(error):
                compeletion(.failed(error: error))
            }
        }
    }

    func uploadImage(
        request: CommunityCreationDataFlow.UploadImage.Request,
        completion: @escaping ((CommunityCreationDataFlow.UploadImageResult) -> Void)
    ) {
        service.uploadImage(request: request) {
            switch $0 {
            case let .success(json):
                if let json = json["path"] as? String {
                    completion(.successful(imagePath: json))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}

//
//  CommunityCreationService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//


import Models
import Extensions

protocol CommunityCreationServiceProtocol {
    func createCommunity(
        request: CommunityCreationDataFlow.CreateCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func uploadImage(
        request: CommunityCreationDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class CommunityCreationService: CommunityCreationServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<CommunityCreationEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<CommunityCreationEndpoint>) {
        self.provider = provider
    }

    // MARK: - CommunityCreationServiceProtocol

    func createCommunity(
        request: CommunityCreationDataFlow.CreateCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .communityCreation(request.communityCreation)) { result in
            completion(result)
        }
    }

    func uploadImage(
        request: CommunityCreationDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        guard let data = request.image.jpeg(.medium) else {
            completion(.failure(.invalidData))
            return
        }

        provider.send(target: .uploadImage(image: data)) { result in
            completion(result)
        }
    }
}

//
//  AddCommentProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol AddCommentProviderProtocol {
    func addComment(
        request: AddCommentDataFlow.AddComment.Request,
        completion: @escaping ((AddCommentDataFlow.AddCommentResult) -> Void)
    )
    func rateRecipe(
        request: AddCommentDataFlow.RateRecipe.Request,
        completion: @escaping ((AddCommentDataFlow.RateRecipeResult) -> Void)
    )
    func uploadImage(
        request: AddCommentDataFlow.UploadImage.Request,
        completion: @escaping ((AddCommentDataFlow.UploadImageResult) -> Void)
    )
}

final class AddCommentProvider: AddCommentProviderProtocol {
    // MARK: - Properties
    private let service: AddCommentServiceProtocol
    
    // MARK: - Init
    init(service: AddCommentServiceProtocol =
                    AddCommentService(provider: AKNetworkProvider<AddCommentEndpoint>())) {
        self.service = service
    }
    
    // MARK: - AddCommentProviderProtocol

    func addComment(
        request: AddCommentDataFlow.AddComment.Request,
        completion: @escaping ((AddCommentDataFlow.AddCommentResult) -> Void)
    ) {
        service.addComment(request: request) {
            switch $0 {
            case let .success(json):
                if let json = json["operationResult"] as? String {
                    completion(.successful(result: AddCommentResultType(rawValue: json) ?? .success))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }

    func rateRecipe(
        request: AddCommentDataFlow.RateRecipe.Request,
        completion: @escaping ((AddCommentDataFlow.RateRecipeResult) -> Void)
    ) {
        service.rateRecipe(request: request) {
            switch $0 {
            case let .success(json):
                if let rating = RatingResponse(json: json) {
                    completion(.successful(model: rating))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }

    func uploadImage(
        request: AddCommentDataFlow.UploadImage.Request,
        completion: @escaping ((AddCommentDataFlow.UploadImageResult) -> Void)
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

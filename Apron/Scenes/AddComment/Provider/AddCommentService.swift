//
//  AddCommentService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AddCommentServiceProtocol {
    func addComment(
        request: AddCommentDataFlow.AddComment.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func rateRecipe(
        request: AddCommentDataFlow.RateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func uploadImage(
        request: AddCommentDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class AddCommentService: AddCommentServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<AddCommentEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AddCommentEndpoint>) {
        self.provider = provider
    }

    // MARK: - AddCommentServiceProtocol

    func rateRecipe(
        request: AddCommentDataFlow.RateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .rateRecipe(body: request.body)) { result in
            completion(result)
        }
    }

    func addComment(
        request: AddCommentDataFlow.AddComment.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .addComment(body: request.body)) { result in
            completion(result)
        }
    }

    func uploadImage(
        request: AddCommentDataFlow.UploadImage.Request,
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

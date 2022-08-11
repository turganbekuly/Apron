//
//  AddCommentInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol AddCommentBusinessLogic {
    func addComment(request: AddCommentDataFlow.AddComment.Request)
    func rateRecipe(request: AddCommentDataFlow.RateRecipe.Request)
    func uploadImage(request: AddCommentDataFlow.UploadImage.Request)
}

final class AddCommentInteractor: AddCommentBusinessLogic {
    // MARK: - Properties
    private let presenter: AddCommentPresentationLogic
    private let provider: AddCommentProviderProtocol
    
    // MARK: - Initialization
    init(presenter: AddCommentPresentationLogic,
         provider: AddCommentProviderProtocol = AddCommentProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - AddCommentBusinessLogic

    func addComment(request: AddCommentDataFlow.AddComment.Request) {
        provider.addComment(request: request) {
            switch $0 {
            case let .successful(result):
                self.presenter.addComment(response: .init(result: .successful(result: result)))
            case let .failed(error):
                self.presenter.addComment(response: .init(result: .failed(error: error)))
            }
        }
    }

    func rateRecipe(request: AddCommentDataFlow.RateRecipe.Request) {
        provider.rateRecipe(request: request) {
            switch $0 {
            case let .successful(model):
                self.presenter.rateRecipe(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self.presenter.rateRecipe(response: .init(result: .failed(error: error)))
            }
        }
    }

    func uploadImage(request: AddCommentDataFlow.UploadImage.Request) {
        provider.uploadImage(request: request) {
            switch $0 {
            case let .successful(imagePath):
                self.presenter.uploadImage(response: .init(result: .successful(imagePath: imagePath)))
            case let .failed(error):
                self.presenter.uploadImage(response: .init(result: .failed(error: error)))
            }
        }
    }
}

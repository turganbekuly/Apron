//
//  AddCommentInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol AddCommentBusinessLogic {
    
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

}

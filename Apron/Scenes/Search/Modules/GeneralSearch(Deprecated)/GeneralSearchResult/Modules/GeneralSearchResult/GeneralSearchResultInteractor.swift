//
//  GeneralSearchResultInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol GeneralSearchResultBusinessLogic {

}

final class GeneralSearchResultInteractor: GeneralSearchResultBusinessLogic {

    // MARK: - Properties
    private let presenter: GeneralSearchResultPresentationLogic
    private let provider: GeneralSearchResultProviderProtocol

    // MARK: - Initialization
    init(presenter: GeneralSearchResultPresentationLogic,
         provider: GeneralSearchResultProviderProtocol = GeneralSearchResultProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - GeneralSearchResultBusinessLogic

}

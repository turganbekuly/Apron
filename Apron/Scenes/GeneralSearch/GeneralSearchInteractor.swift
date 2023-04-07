//
//  GeneralSearchInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol GeneralSearchBusinessLogic {

}

final class GeneralSearchInteractor: GeneralSearchBusinessLogic {

    // MARK: - Properties
    private let presenter: GeneralSearchPresentationLogic
    private let provider: GeneralSearchProviderProtocol

    // MARK: - Initialization
    init(presenter: GeneralSearchPresentationLogic,
         provider: GeneralSearchProviderProtocol = GeneralSearchProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - GeneralSearchBusinessLogic
}

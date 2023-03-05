//
//  FiltersInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol FiltersBusinessLogic {

}

final class FiltersInteractor: FiltersBusinessLogic {

    // MARK: - Properties
    private let presenter: FiltersPresentationLogic
    private let provider: FiltersProviderProtocol

    // MARK: - Initialization
    init(presenter: FiltersPresentationLogic,
         provider: FiltersProviderProtocol = FiltersProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - FiltersBusinessLogic

}

//
//  IngredientInsertionInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol IngredientInsertionBusinessLogic {

}

final class IngredientInsertionInteractor: IngredientInsertionBusinessLogic {

    // MARK: - Properties
    private let presenter: IngredientInsertionPresentationLogic
    private let provider: IngredientInsertionProviderProtocol

    // MARK: - Initialization
    init(presenter: IngredientInsertionPresentationLogic,
         provider: IngredientInsertionProviderProtocol = IngredientInsertionProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - IngredientInsertionBusinessLogic

}

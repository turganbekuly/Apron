//
//  IngredientSelectionInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol IngredientSelectionBusinessLogic {
    
}

final class IngredientSelectionInteractor: IngredientSelectionBusinessLogic {
    
    // MARK: - Properties
    private let presenter: IngredientSelectionPresentationLogic
    private let provider: IngredientSelectionProviderProtocol
    
    // MARK: - Initialization
    init(presenter: IngredientSelectionPresentationLogic,
         provider: IngredientSelectionProviderProtocol = IngredientSelectionProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - IngredientSelectionBusinessLogic

}

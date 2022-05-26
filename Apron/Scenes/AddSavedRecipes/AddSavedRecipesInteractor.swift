//
//  AddSavedRecipesInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol AddSavedRecipesBusinessLogic {
    
}

final class AddSavedRecipesInteractor: AddSavedRecipesBusinessLogic {
    
    // MARK: - Properties
    private let presenter: AddSavedRecipesPresentationLogic
    private let provider: AddSavedRecipesProviderProtocol
    
    // MARK: - Initialization
    init(presenter: AddSavedRecipesPresentationLogic,
         provider: AddSavedRecipesProviderProtocol = AddSavedRecipesProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - AddSavedRecipesBusinessLogic

}

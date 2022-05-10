//
//  SavedRecipesInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol SavedRecipesBusinessLogic {
    
}

final class SavedRecipesInteractor: SavedRecipesBusinessLogic {
    
    // MARK: - Properties
    private let presenter: SavedRecipesPresentationLogic
    private let provider: SavedRecipesProviderProtocol
    
    // MARK: - Initialization
    init(presenter: SavedRecipesPresentationLogic,
         provider: SavedRecipesProviderProtocol = SavedRecipesProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - SavedRecipesBusinessLogic

}

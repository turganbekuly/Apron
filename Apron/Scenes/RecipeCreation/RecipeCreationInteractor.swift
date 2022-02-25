//
//  RecipeCreationInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol RecipeCreationBusinessLogic {
    
}

final class RecipeCreationInteractor: RecipeCreationBusinessLogic {
    
    // MARK: - Properties
    private let presenter: RecipeCreationPresentationLogic
    private let provider: RecipeCreationProviderProtocol
    
    // MARK: - Initialization
    init(presenter: RecipeCreationPresentationLogic,
         provider: RecipeCreationProviderProtocol = RecipeCreationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - RecipeCreationBusinessLogic

}

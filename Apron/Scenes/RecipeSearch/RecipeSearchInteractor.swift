//
//  RecipeSearchInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol RecipeSearchBusinessLogic {
    
}

final class RecipeSearchInteractor: RecipeSearchBusinessLogic {
    
    // MARK: - Properties
    private let presenter: RecipeSearchPresentationLogic
    private let provider: RecipeSearchProviderProtocol
    
    // MARK: - Initialization
    init(presenter: RecipeSearchPresentationLogic,
         provider: RecipeSearchProviderProtocol = RecipeSearchProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - RecipeSearchBusinessLogic

}

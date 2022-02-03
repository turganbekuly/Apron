//
//  RecipePageInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol RecipePageBusinessLogic {
    
}

final class RecipePageInteractor: RecipePageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: RecipePagePresentationLogic
    private let provider: RecipePageProviderProtocol
    
    // MARK: - Initialization
    init(presenter: RecipePagePresentationLogic,
         provider: RecipePageProviderProtocol = RecipePageProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - RecipePageBusinessLogic

}

//
//  IngredientsPageInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol IngredientsPageBusinessLogic {
    
}

final class IngredientsPageInteractor: IngredientsPageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: IngredientsPagePresentationLogic
    private let provider: IngredientsPageProviderProtocol
    
    // MARK: - Initialization
    init(presenter: IngredientsPagePresentationLogic,
         provider: IngredientsPageProviderProtocol = IngredientsPageProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - IngredientsPageBusinessLogic

}

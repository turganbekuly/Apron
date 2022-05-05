//
//  ShoppingListInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol ShoppingListBusinessLogic {
    
}

final class ShoppingListInteractor: ShoppingListBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ShoppingListPresentationLogic
    private let provider: ShoppingListProviderProtocol
    
    // MARK: - Initialization
    init(presenter: ShoppingListPresentationLogic,
         provider: ShoppingListProviderProtocol = ShoppingListProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - ShoppingListBusinessLogic

}

//
//  IngredientSelection+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

extension IngredientSelectionViewController {
    
    // MARK: - Network

    func getProducts(query: String) {
        interactor.getProducts(request: .init(query: query))
    }
}

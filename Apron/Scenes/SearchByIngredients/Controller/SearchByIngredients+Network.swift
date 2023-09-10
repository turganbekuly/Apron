//
//  SearchByIngredients+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

extension SearchByIngredientsViewController {
    
    // MARK: - Network

    func getProductsByIds(ids: [Int]) {
        interactor.getProductsByIds(request: .init(ids: ids))
    }
    
    func getProductsByName(name: String) {
        interactor.getProductsByName(request: .init(name: name))
    }
}

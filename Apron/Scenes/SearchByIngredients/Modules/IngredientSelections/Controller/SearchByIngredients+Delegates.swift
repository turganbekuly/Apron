//
//  SearchByIngredients+Delegates.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 20.08.2023.
//

import UIKit
import Models

extension SearchByIngredientsViewController: SBIProductSelectedCollectionCellProtocol {
    func removeSelected(product: Product) {
        selectedProducts.removeAll(where: { $0.id == product.id })
    }
}

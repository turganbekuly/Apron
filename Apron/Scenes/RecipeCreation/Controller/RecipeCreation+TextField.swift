//
//  RecipeCreation+TextField.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30.04.2022.
//

import UIKit

extension RecipeCreationViewController: NamingCellDelegate {
    func cell(_ cell: RecipeCreationNamingCell, didEnteredName name: String?) {
        recipeCreation?.recipeName = name
    }
}

extension RecipeCreationViewController: DescriptionCellDelegate {
    func cell(_ cell: RecipeCreationDescriptionCell, didEnteredDesc descr: String?) {
        recipeCreation?.description = descr
    }
}

extension RecipeCreationViewController: SourceURLDelegate {
    func cell(_ cell: RecipeCreationSourceURLCell, didEnterSource source: String?) {
        recipeCreation?.sourceLink = source
    }
}


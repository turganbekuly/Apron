//
//  RecipeCreationStorage.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 04.09.2022.
//

import Disk
import Models

public protocol RecipeCreationStorageProtocol: AnyObject {
    var recipeCreation: RecipeCreation? { get set }
}

public final class RecipeCreationStorage: RecipeCreationStorageProtocol {

    private enum Constant {
        static let recipeCreation = "RecipeCreationStorage/recipeCreation.json"
    }

    // MARK: - Properties

    public var recipeCreation: RecipeCreation? {
        get { try? Disk.retrieve(Constant.recipeCreation, from: .caches, as: RecipeCreation.self) }
        set { try? Disk.save(newValue, to: .caches, as: Constant.recipeCreation) }
    }

    // MARK: - Init

    public init() {}

}

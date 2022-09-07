//
//  RecipeCreationStorage.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 04.09.2022.
//

import Disk
import Models
import KeychainAccess

public protocol RecipeCreationStorageProtocol: AnyObject {
    var recipeCreation: RecipeCreation? { get set }
    var isCookAssistEnabled: Bool { get set }
}

public final class RecipeCreationStorage: RecipeCreationStorageProtocol {

    private enum Constant {
        static let recipeCreation = "RecipeCreationStorage/recipeCreation.json"
        static let recipeCookAssistant = "isCookAssistEnabled"
    }

    // MARK: - Properties

    private let keychain: Keychain

    public var recipeCreation: RecipeCreation? {
        get { try? Disk.retrieve(Constant.recipeCreation, from: .caches, as: RecipeCreation.self) }
        set { try? Disk.save(newValue, to: .caches, as: Constant.recipeCreation) }
    }

    public var isCookAssistEnabled: Bool {
        get { RecipeCreationStorage.isCookAssistEnabled }
        set { RecipeCreationStorage.isCookAssistEnabled = newValue }
    }

    // MARK: - Init

    public init() {
        keychain = Keychain()
    }

}

private extension RecipeCreationStorage {
    // MARK: - To show cook assist

    @UserDefaultsEntry("isCookAssistEnabled", defaultValue: false)
    static var isCookAssistEnabled: Bool
}

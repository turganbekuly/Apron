//
//  LastRecipeHistoryStorage.swift
//  Storages
//
//  Created by Акарыс Турганбекулы on 01.12.2023.
//

import Disk
import Models
import KeychainAccess

public protocol LastRecipeHistoryStorageProtocol: AnyObject {
    var whenToCook: [Int]? { get set }
    var lastSearchTerm: String? { get set }
    var lastRecipeName: String? { get set }
}

public final class LastRecipeHistoryStorage: LastRecipeHistoryStorageProtocol {
    private enum Constant {
        static let whenToCook = "whenToCook"
        static let lastSearchTerm = "lastSearchTerm"
        static let lastRecipeName = "lastRecipeName"
    }

    // MARK: - Properties

    private let keychain: Keychain
    
    public var whenToCook: [Int]? {
        get { try? Disk.retrieve(Constant.whenToCook, from: .caches, as: [Int].self) }
        set { try? Disk.save(newValue, to: .caches, as: Constant.whenToCook) }
    }
    
    public var lastSearchTerm: String? {
        get { try? Disk.retrieve(Constant.lastSearchTerm, from: .caches, as: String.self) }
        set { try? Disk.save(newValue, to: .caches, as: Constant.lastSearchTerm) }
    }
    
    public var lastRecipeName: String? {
        get { try? Disk.retrieve(Constant.lastRecipeName, from: .caches, as: String.self) }
        set { try? Disk.save(newValue, to: .caches, as: Constant.lastRecipeName) }
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

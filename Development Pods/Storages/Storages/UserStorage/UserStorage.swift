//
//  UserStorage.swift
//  Models
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Disk
import Models

public protocol UserStorageProtocol: AnyObject {
    var user: User? { get set }
    func clear()
}

public final class UserStorage: UserStorageProtocol {

    private enum Constant {
        static let user = "UserStorage/user.json"
    }

    // MARK: - Properties

    public var user: User? {
        get { try? Disk.retrieve(Constant.user, from: .caches, as: User.self) }
        set { try? Disk.save(newValue, to: .caches, as: Constant.user) }
    }

    // MARK: - Init

    public init() {}

    // MARK: - Methods

    public func clear() {
        user = nil
    }

}

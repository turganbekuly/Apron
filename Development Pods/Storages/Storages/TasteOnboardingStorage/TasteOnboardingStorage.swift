//
//  UserStorage.swift
//  AlignedCollectionViewFlowLayout
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import Disk
import Models

public protocol ITasteOnboardingStorage: AnyObject {
    var model: TasteOnboardingModel? { get set }
    func clear()
}

public final class TasteOnboardingStorage: ITasteOnboardingStorage {

    private enum Constant {
        static let model = "MCUserStorage/onboarding.json"
    }

    // MARK: - Properties

    public var model: TasteOnboardingModel? {
        get { try? Disk.retrieve(Constant.model, from: .caches, as: TasteOnboardingModel.self) }
        set { try? Disk.save(newValue, to: .caches, as: Constant.model) }
    }

    // MARK: - Init

    public init() {}

    // MARK: - Methods

    public func clear() {
        model = nil
    }

}

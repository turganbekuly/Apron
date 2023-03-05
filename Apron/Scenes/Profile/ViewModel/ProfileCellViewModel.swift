//
//  ProfileCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.07.2022.
//

// import MCFormatters
import Models
import APRUIKit
import UIKit

public protocol ProfileUserCellProtocol {
    var username: NSAttributedString? { get }
    var email: NSAttributedString? { get }
}

public struct ProfileUserCellViewModel: ProfileUserCellProtocol {

    // MARK: - Properties

    public let user: User?

    // MARK: - ProfileUserCellProtocol

    public var username: NSAttributedString? {
        var text = ""
        if let name = user?.username, !name.isEmpty {
            text += name
        }

        return Typography.semibold24(text: text).styled
    }

    public var email: NSAttributedString? {
        var text = ""
        if let email = user?.email, !email.isEmpty {
            text += email
        }

        return Typography.regular16(text: text).styled
    }

    // MARK: - Init

    public init(user: User?) {
        self.user = user
    }

}

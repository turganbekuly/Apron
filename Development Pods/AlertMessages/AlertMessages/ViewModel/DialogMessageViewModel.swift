import APRUIKit
import UIKit

public struct DialogMessageViewModel: MessageProtocol {

    // MARK: - Properties

    private let titleText: String
    private let subtitleText: String
    private let firstButtonTitleText: String
    private let secondButtonTitleText: String

    // MARK: - MessageProtocol

    public var icon: UIImage? {
        nil
    }

    public var title: NSAttributedString? {
        Typography.medium16(text: titleText).styled
    }

    public var subtitle: NSAttributedString? {
        Typography.regular14(text: subtitleText).styled
    }

    public var firstButtonTitle: NSAttributedString? {
        Typography.semibold14(text: firstButtonTitleText, color: .white).styled
    }

    public var secondButtonTitle: NSAttributedString? {
        Typography.semibold14(text: secondButtonTitleText, color: .white).styled
    }

    public var backgroundColor: UIColor {
        ApronAssets.mainAppColor.color
    }

    public var titleColor: UIColor {
        .white
    }

    public var subtitleColor: UIColor? {
        .white
    }

    public var iconColor: UIColor? {
        nil
    }

    // MARK: - Init

    public init(title: String, subtitle: String, firstButtonTitle: String, secondButtonTitle: String) {
        titleText = title
        subtitleText = subtitle
        firstButtonTitleText = firstButtonTitle
        secondButtonTitleText = secondButtonTitle
    }

}

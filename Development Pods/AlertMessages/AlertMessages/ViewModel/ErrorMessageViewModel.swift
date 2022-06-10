import APRUIKit
import UIKit

public struct ErrorMessageViewModel: MessageProtocol {

    // MARK: - Properties

    private let titleText: String

    // MARK: - MessageProtocol

    public var icon: UIImage? {
        ApronAssets.attention.image
    }

    public var title: NSAttributedString? {
        Typography.semibold14(text: titleText).styled
    }

    public var subtitle: NSAttributedString? {
        nil
    }

    public var firstButtonTitle: NSAttributedString? {
        nil
    }

    public var secondButtonTitle: NSAttributedString? {
        nil
    }

    public var backgroundColor: UIColor {
        ApronAssets.red.color
    }

    public var titleColor: UIColor {
        .white
    }

    public var subtitleColor: UIColor? {
        nil
    }

    public var iconColor: UIColor? {
        .white
    }

    // MARK: - Init

    public init(title: String) {
        titleText = title
    }

}

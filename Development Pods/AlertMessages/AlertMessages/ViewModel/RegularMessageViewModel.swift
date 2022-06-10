import APRUIKit
import UIKit

public struct RegularMessageViewModel: MessageProtocol {

    // MARK: - Properties

    private let titleText: String

    // MARK: - MessageProtocol

    public var icon: UIImage?

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
        ApronAssets.gray.color
    }

    public var titleColor: UIColor {
        .black
    }

    public var subtitleColor: UIColor? {
        nil
    }

    public var iconColor: UIColor? {
        ApronAssets.blue.color
    }

    // MARK: - Init

    public init(icon: UIImage, title: String) {
        self.icon = icon
        titleText = title
    }

}

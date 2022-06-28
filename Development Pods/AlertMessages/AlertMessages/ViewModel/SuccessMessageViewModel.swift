import APRUIKit
import UIKit

public struct SuccessMessageViewModel: MessageProtocol {

    // MARK: - Properties

    private let titleText: String

    // MARK: - MessageProtocol

    public var icon: UIImage? {
        ApronAssets.checkOvalOutline.image
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
        ApronAssets.colorsYello.color
    }

    public var titleColor: UIColor {
        .black
    }

    public var subtitleColor: UIColor? {
        nil
    }

    public var iconColor: UIColor? {
        .black
    }

    // MARK: - Init

    public init(title: String) {
        titleText = title
    }

}

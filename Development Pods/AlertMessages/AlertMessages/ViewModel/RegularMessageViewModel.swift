import APRUIKit
import UIKit

public struct RegularMessageViewModel: MessageProtocol {

    // MARK: - Properties

    private let titleText: String
    private let firstButtonTitleText: String

    // MARK: - MessageProtocol

    public var icon: UIImage? {
        return nil
    }

    public var title: NSAttributedString? {
        Typography.semibold14(text: titleText).styled
    }

    public var subtitle: NSAttributedString? {
        nil
    }

    public var firstButtonTitle: NSAttributedString? {
        Typography.semibold14(text: firstButtonTitleText, color: .white).styled
    }

    public var secondButtonTitle: NSAttributedString? {
        nil
    }

    public var backgroundColor: UIColor {
        .black
    }

    public var titleColor: UIColor {
        .white
    }

    public var subtitleColor: UIColor? {
        nil
    }

    public var iconColor: UIColor? {
        ApronAssets.blue.color
    }

    // MARK: - Init

    public init(title: String, firstButtonTitleText: String) {
        self.titleText = title
        self.firstButtonTitleText = firstButtonTitleText
    }

}

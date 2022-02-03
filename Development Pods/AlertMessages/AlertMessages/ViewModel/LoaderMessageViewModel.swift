import DesignSystem
import UIKit

public struct LoaderMessageViewModel: MessageProtocol {
    // MARK: - MessageProtocol

    public var icon: UIImage? {
        nil
    }

    public var title: NSAttributedString? {
        nil
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
        .clear
    }

    public var titleColor: UIColor {
        .black
    }

    public var subtitleColor: UIColor? {
        nil
    }

    public var iconColor: UIColor? {
        nil
    }

    // MARK: - Init

    public init() {}
}

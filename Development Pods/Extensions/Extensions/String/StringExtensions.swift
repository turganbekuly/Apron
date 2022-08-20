import Foundation

extension String {

    // MARK: - Properties

    public var isLatin: Bool {
        range(of: "\\P{Latin}", options: .regularExpression) == nil
    }

}

extension String {
    public func heightLabel(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.sizeToFit()
        return label.frame.height
    }

    public func heightTextView(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        textView.font = font
        return textView.frame.height
    }
}

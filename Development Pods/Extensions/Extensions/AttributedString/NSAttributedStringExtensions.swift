import UIKit

extension NSAttributedString {

    // MARK: - NSAttributedString

    public convenience init(
        _ string: String,
        _ color: UIColor = .black,
        _ font: UIFont = UIFont.systemFont(ofSize: 14),
        _ alignment: NSTextAlignment = .left,
        _ letterSpacing: CGFloat?,
        _ lineHeight: CGFloat? = nil,
        _ url: URL? = nil
    ) {
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
        }
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = .byWordWrapping
        var attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle,
            .font: font
        ]
        if let letterSpacing = letterSpacing {
            attrs[.kern] = letterSpacing
        }
        if let url = url {
            attrs[.link] = url
        }
        self.init(string: string, attributes: attrs)
    }

    // MARK: - Height

    public func height(containerWidth: CGFloat) -> CGFloat {
        let rect = boundingRect(
            with: .init(width: containerWidth, height: CGFloat.greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        return ceil(rect.size.height)
    }

}

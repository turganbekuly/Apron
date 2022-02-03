import UIKit

extension UIView {

    // MARK: - Methods

    public func addShadow(
        offset: CGSize,
        radius: CGFloat,
        opacity: Float,
        cornerRadius: CGFloat? = nil
    ) {
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        if let radius = cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        }
    }

}

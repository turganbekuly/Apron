import UIKit

extension UIColor {

    // MARK: - Properties

    public var highlighted: UIColor {
        adjustBrightness(by: -abs(10.0))
    }

    // MARK: - Init

    public convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
    }

    // MARK: - Methods

    private func adjustBrightness(by percentage: CGFloat = 30.0) -> UIColor {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            if brightness < 1.0 {
                let newB: CGFloat = max(min(brightness + (percentage / 100.0) * brightness, 1.0), 0.0)
                return UIColor(hue: hue, saturation: saturation, brightness: newB, alpha: alpha)
            } else {
                let newS: CGFloat = min(max(saturation - (percentage / 100.0) * saturation, 0.0), 1.0)
                return UIColor(hue: hue, saturation: newS, brightness: brightness, alpha: alpha)
            }
        }
        return self
    }

}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(
           red: .random(),
           green: .random(),
           blue: .random(),
           alpha: 1.0
        )
    }
}

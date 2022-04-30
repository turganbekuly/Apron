import Foundation

extension Decimal {

    public var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }

}

extension Double {
    public var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

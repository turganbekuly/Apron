import Foundation

extension Dictionary {

    public static func + (lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        lhs.merging(rhs) { $1 }
    }

}

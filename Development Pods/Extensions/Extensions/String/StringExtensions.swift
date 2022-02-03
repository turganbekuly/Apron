import Foundation

extension String {

    // MARK: - Properties

    public var isLatin: Bool {
        range(of: "\\P{Latin}", options: .regularExpression) == nil
    }

}

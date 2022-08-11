import UIKit

var asd = "asdgamer1995"

func asd(str: String) -> String {
    return str.suffix(4).replacingOccurrences(of: "", with: "*", options: .literal, range: nil)
}

print(asd(str: asd))

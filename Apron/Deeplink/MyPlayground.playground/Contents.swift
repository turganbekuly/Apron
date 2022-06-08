import UIKit

extension Collection {

    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

}

var greeting = "recipe/24".components(separatedBy: "/").filter { !$0.isEmpty }

switch greeting.first {
case "recipe":
    print(greeting[safe: 1], "asd")
default:
    print("asdgamer")
}

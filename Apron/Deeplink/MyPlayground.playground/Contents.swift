import Foundation

struct ASD {
    let id: Int
    let image: String?
}
let asd = [
    ASD(id: 0, image: "asd"),
    ASD(id: 1, image: nil),
    ASD(id: 2, image: ""),
    ASD(id: 3, image: nil)
]

if asd.compactMap({ $0.image }) != nil {
    print("asd")
} else {
    print("dsa")
}

import Foundation

struct FeatureToggleTagStorage {
    enum TagType {
        case all
        case tag(Tag)
        
        var rawValue: String? {
            switch self {
            case .all:
                return nil
            case .tag(let tag):
                return tag.rawValue
            }
        }
        
    }
    
    typealias Tag = FeatureToggleTag
    
    let type: Tag.Type
    let currentTag: TagType
    let allCases: [Tag]
    let view: FeatureToggleTagViewProtocol
    
}

//
//  Main+Section.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Models

extension MainViewController {
    
    struct Section {
        enum Section {
            case myCommunity
            case communities
        }
        
        enum Row: Equatable {
            case myCommunities(Bool)
            case communities(String, Bool, [CommunityResponse])
            
            static func == (lhs: Row, rhs: Row) -> Bool {
                switch (lhs, rhs) {
                case (.myCommunities, myCommunities):
                    return true
                case (.communities, communities):
                    return true
                default:
                    return false
                }
            }
        }
        
        let section: Section
        var rows: [Row]
    }
    
    struct MyCommunitiesSection {
        enum Section {
            case myCommunities
        }
        
        enum Row {
            case myCommunity(CommunityResponse)
        }
        
        var section: Section
        var rows: [Row]
    }
}

extension DynamicCommunityCell {
    struct DynamicCommunitySection {
        public enum Section {
            case communities
        }

        enum Row {
            case community(CommunityResponse)
        }

        var section: Section
        var rows: [Row]
    }
}

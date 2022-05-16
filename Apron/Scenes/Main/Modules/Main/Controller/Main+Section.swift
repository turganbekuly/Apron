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

        enum Row {
            case myCommunities
            case communities(String)
        }

        let section: Section
        var rows: [Row]
    }

    struct CommunitySection {
        public enum Section {
            case myCommunities
            case communities
        }

        enum Row {
            case community(CommunityCollectionCellViewModel)
        }

        var section: Section
        var rows: [Row]
    }
}



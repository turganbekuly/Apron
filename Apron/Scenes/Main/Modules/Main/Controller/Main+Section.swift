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
            case my
            case featured
            case quickSimple
            case healthy
            case homemade
        }

        enum Row {
            case myCommunities
            case featuredCommunities
            case quickSimpleCommunities
            case healthyCommunities
            case homemadeCommunities
        }

        let section: Section
        var rows: [Row]
    }

    struct CommunitySection {
        public enum Section {
            case myCommunities
            case featuredCommunities
            case quickSimpleCommunities
            case healthyCommunities
            case homemadeCommunities
        }

        enum Row {
            case community(CommunityCollectionCellViewModel)
        }

        var section: Section
        var rows: [Row]
    }
}



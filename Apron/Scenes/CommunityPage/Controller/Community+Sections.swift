//
//  Community+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import Foundation

extension CommunityPageViewController {
    public struct Section {
        enum Section {
            case topView
            case filterView
            case recipiesView
        }
        enum Row: Equatable {
            case topView(CommunityInfoCellViewModel)
            case filterView(CommunityFilterCellViewModel)
            case segment
            case recipiesView

            static func == (lhs: Row, rhs: Row) -> Bool {
                switch (lhs, rhs) {
                case (.recipiesView, .recipiesView):
                    return true
                case (.topView, .topView):
                    return true
                case (.filterView, .filterView):
                    return true
                case (.segment, .segment):
                    return true
                default:
                    return false
                }
            }
        }

        let section: Section
        let rows: [Row]
    }

    public struct CommunityPageCollectionSection {
        enum Section {
            case recipes
        }
        enum Row {
            case recipes(CommunityRecipesCollectionCellViewModel)
        }
        var section: Section
        var rows: [Row]
    }
}

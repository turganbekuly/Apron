//
//  Community+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.01.2022.
//

import Foundation
import Models

extension CommunityPageViewController {
    public struct Section {
        enum Section {
            case topView
        }
        enum Row: Equatable {
            case recipiesView(RecipeResponse)
            case emptyView

            static func == (lhs: Row, rhs: Row) -> Bool {
                switch (lhs, rhs) {
                case (.recipiesView, .recipiesView):
                    return true
                case (.emptyView, .emptyView):
                    return true
                default:
                    return false
                }
            }
        }

        var section: Section
        var rows: [Row]
    }
}

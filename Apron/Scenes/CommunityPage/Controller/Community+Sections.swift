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
            case result(RecipeResponse)
            case shimmer

            static func == (lhs: Row, rhs: Row) -> Bool {
                switch (lhs, rhs) {
                case (.result, .result):
                    return true
                case (.shimmer, .shimmer):
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

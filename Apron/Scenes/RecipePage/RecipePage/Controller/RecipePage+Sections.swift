//
//  RecipePage+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import Foundation
import Wormholy

extension RecipePageViewController {
    public struct Section {
        enum Section {
            case topView
            case pages
        }
        enum Row: Equatable {
            case topView
            case page

            static func ==(lhs: Row, rhs: Row) -> Bool {
                switch (lhs, rhs) {
                case (.topView, .topView):
                    return true
                case (.page, .page):
                    return true
                default:
                    return false
                }
            }
        }

        let section: Section
        let rows: [Row]
    }

    public struct PagesCollectionSection {
        enum Section {
            case pages
        }
        enum Row {
            case page
        }
        var section: Section
        var rows: [Row]
    }
}

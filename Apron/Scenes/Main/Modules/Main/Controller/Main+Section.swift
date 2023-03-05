//
//  Main+Section.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Models
import RemoteConfig

extension MainViewController {

    struct Section {
        enum Section {
            case adBanner
            case communities
            case whatToCook
            case cookNow
            case eventRecipes
//            case createRecipe
        }

        enum Row: Equatable {
            case adBanner([AdBannerObject])
            case communities(String, [CommunityResponse], Int)
            case whatToCook(String)
            case cookNow(String, [RecipeResponse])
            case eventRecipes(String, [RecipeResponse])
//            case createRecipe

            static func == (lhs: Row, rhs: Row) -> Bool {
                switch (lhs, rhs) {
                case (.adBanner, .adBanner):
                    return true
                case (.communities, .communities):
                    return true
                case (.whatToCook, .whatToCook):
                    return true
                case (.cookNow, .cookNow):
                    return true
                case (.eventRecipes, .eventRecipes):
                    return true
//                case (.createRecipe, .createRecipe):
//                    return true
                default:
                    return false
                }
            }
        }

        let section: Section
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
            case loader
        }

        var section: Section
        var rows: [Row]
    }
}

extension WhatToCookCell {
    struct WhatToCookSection {
        enum Section {
            case categories
        }

        enum Row {
            case category(WhatToCookCategoryTypes)
        }

        var section: Section
        var rows: [Row]
    }
}

extension CookNowCell {
    struct CookNowSection {
        enum Section {
            case recipes
        }
        enum Row {
            case shimmer
            case recipe(RecipeResponse)
        }

        var section: Section
        var rows: [Row]
    }
}

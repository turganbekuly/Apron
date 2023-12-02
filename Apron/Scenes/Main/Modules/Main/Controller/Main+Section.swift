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
            case searchByIngredients
            case communities
            case whatToCook
            case cookNow
            case eventRecipes
            //            case createRecipe
        }
        
        enum Row: Equatable {
            case recipeLoader
            case adBanner([AdBannerObject])
            case searchByIngredients(String, String, [Product])
            case communities(String, [CommunityResponse])
            case whatToCook(String)
            case cookNow(RecipeResponse)
            case eventRecipes(String, [RecipeResponse])
            //            case createRecipe
            
            static func == (lhs: Row, rhs: Row) -> Bool {
                switch (lhs, rhs) {
                case (.adBanner, .adBanner):
                    return true
                case (.searchByIngredients, .searchByIngredients):
                    return true
                case (.communities, .communities):
                    return true
                case (.whatToCook, .whatToCook):
                    return true
                case (.cookNow, .cookNow):
                    return true
                case (.eventRecipes, .eventRecipes):
                    return true
                case (.recipeLoader, .recipeLoader):
                    return true
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

extension CommunityCell {
    struct CommunitySection {
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

extension AdBannerCell {
    struct AdBannerSection {
        enum Section {
            case banners
        }
        enum Row {
            case banner(AdBannerObject)
        }
        
        var section: Section
        var rows: [Row]
    }
}

extension SBIMainTableCell {
    struct SBIMainSection {
        enum Section {
            case products
        }
        enum Row {
            case product(Product)
            case seeAll
        }
        var section: Section
        var rows: [Row]
    }
}

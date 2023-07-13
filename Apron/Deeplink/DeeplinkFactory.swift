//
//  DeeplinkFactory.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

import Foundation
import Configurations
import AppsFlyerLib

 final class DeeplinkFactory {

    // MARK: - Make Deeplink

     func makeAppsflyerDeeplink(with deeplink: DeepLink) -> CustomDeepLink {
         let dict = deeplink.clickEvent
         if let _ = dict["saved_recipes"] as? String {
             return .openSavedRecipes
         }
         if let _ = dict["shopping_list"] as? String {
             return .openShoppingList
         }
         if let _ = dict["meal_planner"] as? String {
             return .openMealPlanner
         }
         if let _ = dict["recipe_creation"] as? String {
             return .openRecipeCreation
         }
         if let receipeId = dict["recipe_id"] as? String {
             return .openRecipe(id: Int(receipeId) ?? 1)
         }
         return .unknown
     }

     func makeAppsFlyerConversionDeepLink(with deeplink: [AnyHashable: Any]) -> CustomDeepLink {
         if let _ = deeplink["saved_recipes"] as? String {
             return .openSavedRecipes
         }
         if let _ = deeplink["shopping_list"] as? String {
             return .openShoppingList
         }
         if let receipeId = deeplink["recipe_id"] as? String {
             return .openRecipe(id: Int(receipeId) ?? 1)
         }
         if let _ = deeplink["meal_planner"] as? String {
             return .openMealPlanner
         }
         if let _ = deeplink["recipe_creation"] as? String {
             return .openRecipeCreation
         }
         return .unknown
     }

     func makeDeeplink(from url: URL) -> CustomDeepLink {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard
            let host = urlComponents?.host,
            let urlPath = urlComponents?.path
        else { return .unknown }

        let components = urlPath.components(separatedBy: "/").filter { !$0.isEmpty }
        switch host {
        case Configurations.getDeeplinkBaseURL():
            return getBaseDeeplink(from: components)
        default:
            return .unknown
        }
    }

    private func getBaseDeeplink(from components: [String]) -> CustomDeepLink {
        switch components.count {
        case 1:
            switch components.first {
            case "saved_recipes":
                return .openSavedRecipes
            case "meal_planner":
                return .openMealPlanner
            case "recipe_creation":
                return .openRecipeCreation
            case "shopping_list":
                return .openShoppingList
            default:
                return .unknown
            }
        case 2:
            switch components.first {
            case "community":
                guard
                    let adIDString = components[safe: 1],
                    let adID = Int(adIDString)
                else { return .unknown }

                return .openCommunity(id: adID)
            case "recipe":
                guard
                    let adIDString = components[safe: 1],
                    let adID = Int(adIDString)
                else { return .unknown }

                return .openRecipe(id: adID)
//            case "profile":
//                guard let profilePage = components[safe: 1] else { return .unknown }
//
//                switch profilePage {
//                case "favourites":
//                    return .openFavorites
//                case "my-ations":
//                    return .openPersonalAds
//                default:
//                    return .unknown
//                }
            default:
                return .unknown
            }
        default:
            return .unknown
        }
    }
}

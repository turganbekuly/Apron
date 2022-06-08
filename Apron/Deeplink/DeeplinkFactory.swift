//
//  DeeplinkFactory.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

import Foundation
import Configurations

 final class DeeplinkFactory {

    // MARK: - Make Deeplink

     func makeDeeplink(from url: URL) -> Deeplink {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard
            let urlHost = urlComponents?.host,
            let urlPath = urlComponents?.path
        else { return .unknown }

        let components = urlPath.components(separatedBy: "/").filter { !$0.isEmpty }
        switch urlHost {
        case Configurations.getWebBaseHost():
            return getBaseDeeplink(from: components)
        default:
            return .unknown
        }
    }

    private func getBaseDeeplink(from components: [String]) -> Deeplink {
        switch components.count {
        case 1:
            switch components.first {
            case "saved":
                return .openSavedRecipes
            case "planner":
                return .openPlanner
            case "list":
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


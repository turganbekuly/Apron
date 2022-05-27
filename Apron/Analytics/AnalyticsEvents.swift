//
//  AnalyticsEvents.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.05.2022.
//

import Foundation
import Models

enum CustomerStatus: String {
    case loggedIn = "logged_in"
    case guest
}

enum AddButtonTypeStatus: String {
    case privateCommunity = "private_community"
    case publicCommunity = "public_community"
    case newRecipe = "new_recipe"
    case savedRecipe = "saved_recipe"
}

enum AnalyticsEvents {
    case homePageViewed(HomePageViewedModel)
}

extension AnalyticsEvents: AnalyticsEventProtocol {
    var name: String {
        switch self {
        case .homePageViewed:
            return "home_page_viewed"
        }
    }

    var eventProperties: [String : Any] {
        switch self {
        case .homePageViewed(_):
            return [:]
        }
    }
}

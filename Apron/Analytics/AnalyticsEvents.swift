//
//  AnalyticsEvents.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.05.2022.
//

import Foundation
import Models

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

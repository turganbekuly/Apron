//
//  ABKeyType.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 09.02.2023.
//

import Foundation

public enum ABKeyType: String, CaseIterable {
    case isNewGroceryPageEnabled = "grocery_page_redesign"
    case productCardRedesign = "product_card_redesign"
    case loyaltyProgram = "loyalty_program"
    case isRecommendationsEnabled = "product_recommendations"
    case isSnoomartHomepageV2Enabled = "snoomart_homepage_v2"
}

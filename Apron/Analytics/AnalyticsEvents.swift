//
//  AnalyticsEvents.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.05.2022.
//

import Foundation
import Models

// MARK: - One parameter event parameters

enum CustomerStatus: String {
    case loggedIn = "logged_in"
    case guest
}

enum RecipeCreationSourceTypeModel: String, Codable {
    case community = "community_page"
    case saved = "saved_recipes"
    case deeplink
    case search
}

enum CommunityCreationSourceTypeModel: String, Codable {
    case publicButton = "public_button"
    case privateButton = "private_button"
}

// MARK: - AnalyticsEvents

enum AnalyticsEvents {
    case homePageViewed(CustomerStatus)
    case authorization(AuthorizationModel)
    case communitiesListPageViewed(CommunitiesListPageViewedModel)
    case communityPageViewed(CommunityPageViewedModel)
    case joinedCommunity(JoinedCommunityModel)
    case communityCreated(CommunityCreatedModel)
    case searchMade(SearchMadeModel)
    case communityCreationPageViewed(CommunityCreationSourceTypeModel)
    case recipeCreationPageViewed(RecipeCreationSourceTypeModel)
    case recipeCreated(RecipeCreatedModel)
    case recipePageViewed(RecipePageViewedModel)
    case recipeIngredientsAddedToShoppingList([String])
    case shoppingListViewed
    case ingredientAdded(IngredientAddedModel)
}

extension AnalyticsEvents: AnalyticsEventProtocol {
    var name: String {
        switch self {
        case .homePageViewed:
            return "home_page_viewed"
        case .authorization:
            return "authorization"
        case .communitiesListPageViewed:
            return "commuties_list_page_viewed"
        case .communityPageViewed:
            return "community_page_viewed"
        case .joinedCommunity:
            return "joined_community"
        case .communityCreated:
            return "community_created"
        case .searchMade:
            return "search_made"
        case .communityCreationPageViewed:
            return "community_creation_page_viewed"
        case .recipeCreationPageViewed:
            return "recipe_creation_page_viewed"
        case .recipeCreated:
            return "recipe_created"
        case .recipePageViewed:
            return "recipe_page_viewed"
        case .recipeIngredientsAddedToShoppingList:
            return "recipe_ingredients_added_to_shopping_list"
        case .shoppingListViewed:
            return "shopping_list_viewed"
        case .ingredientAdded:
            return "ingredient_added"
        }
    }

    var eventProperties: [String : Any] {
        switch self {
        case let .homePageViewed(model):
            return ["customer_status": model.rawValue]
        case let .authorization(model):
            return model.toJSON()
        case let .communitiesListPageViewed(model):
            return model.toJSON()
        case let .communityPageViewed(model):
            return model.toJSON()
        case let .joinedCommunity(model):
            return model.toJSON()
        case let .communityCreated(model):
            return model.toJSON()
        case let .searchMade(model):
            return model.toJSON()
        case let .communityCreationPageViewed(model):
            return ["source_type": model.rawValue]
        case let .recipeCreationPageViewed(model):
            return ["source_type": model.rawValue]
        case let .recipeCreated(model):
            return model.toJSON()
        case let .recipePageViewed(model):
            return model.toJSON()
        case let .recipeIngredientsAddedToShoppingList(model):
            return ["ingredients": model]
        case .shoppingListViewed:
            return [:]
        case let .ingredientAdded(model):
            return model.toJSON()
        }
    }
}

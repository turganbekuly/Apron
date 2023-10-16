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
    case myRecipes
    case deeplink
    case search
    case main
    case banner
    case recipePage
    case searchByIngredients = "search_by_ingredients"
    case mealPlanner = "meal_planner"
}

enum RecipeCategoriesType: String, Codable {
    case main
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
    case authorizationFailed(String)
    case communitiesListPageViewed(CommunitiesListPageViewedModel)
    case communityPageViewed(CommunityPageViewedModel)
    case joinedCommunity(JoinedCommunityModel)
    case communityCreated(CommunityCreatedModel)
    case searchMade(SearchMadeModel)
    case communityCreationPageViewed(CommunityCreationSourceTypeModel)
    case recipeCreationPageViewed(RecipeCreationSourceTypeModel)
    case recipeCreated(RecipeCreatedModel)
    case recipePageViewed(RecipePageViewedModel)
    case recipePageRecommendationTapped(recipeName: String, rowPlace: CGFloat)
    case recipeAddedToFavorite(String)
    case shoppingListViewed
    case ingredientAdded(IngredientAddedModel)
    case shoppingListCheckoutTapped([String])
    case shoppingListShareTapped([String])
    case stepByStepViewed(CGFloat)
    case filtersApplied(SearchFilterRequestBody)
    case adBannerTapped(AdBannerModel)
    case authorizationSkipped(Bool)
    case authorizationPageViewed
    case categoriesTapped(String, RecipeCategoriesType)
    case mealPlannerPageViewed
    case mealPlannerMealAdded(String)
    case communityTapped(String)
    case searchByIngredientsViewed
    case searchByIngredientsResult(products: [Product])
    case accountDeleted(user: User?)
}

extension AnalyticsEvents: AnalyticsEventProtocol {
    var name: String {
        switch self {
        case .homePageViewed:
            return "home_page_viewed"
        case .authorization:
            return "authorization"
        case .authorizationFailed:
            return "authorization_failed"
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
        case .recipePageRecommendationTapped:
            return "recipe_page_recommendation_tapped"
        case .recipeAddedToFavorite:
            return "recipe_added_to_favorite"
        case .shoppingListViewed:
            return "shopping_list_viewed"
        case .ingredientAdded:
            return "ingredients_added"
        case .stepByStepViewed:
            return "step_by_step_viewed"
        case .shoppingListCheckoutTapped:
            return "shopping_list_checkout_tapped"
        case .shoppingListShareTapped:
            return "shopping_list_share_tapped"
        case .filtersApplied:
            return "search_filters_applied"
        case .adBannerTapped:
            return "ad_banner_tapped"
        case .authorizationSkipped:
            return "authorization_skipped"
        case .authorizationPageViewed:
            return "authorization_page_viewed"
        case .categoriesTapped:
            return "recipe_categories_tapped"
        case .mealPlannerPageViewed:
            return "meal_planner_page_viwed"
        case .mealPlannerMealAdded:
            return "meal_planner_meal_added"
        case .communityTapped:
            return "main_page_community_tapped"
        case .searchByIngredientsViewed:
            return "search_by_ingredients_viewed"
        case .searchByIngredientsResult:
            return "search_by_ingredients_result"
        case .accountDeleted:
            return "account_deleted"
        }
    }

    var eventProperties: [String: Any] {
        switch self {
        case let .homePageViewed(model):
            return ["customer_status": model.rawValue]
        case let .authorization(model):
            return model.toJSON()
        case let .authorizationFailed(error):
            return ["result": error]
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
        case let .recipePageRecommendationTapped(recipeName, rowPlace):
            return ["recipe_name": recipeName, "row_place": rowPlace]
        case let .recipeAddedToFavorite(recipeName):
            return ["recipe_name": recipeName]
        case .shoppingListViewed:
            return [:]
        case let .ingredientAdded(model):
            return model.toJSON()
        case let .stepByStepViewed(progress):
            return ["last_progress": progress]
        case let .shoppingListCheckoutTapped(ingredients):
            return ["ingredients": ingredients]
        case let .shoppingListShareTapped(ingredients):
            return ["ingredients": ingredients]
        case let .filtersApplied(model):
            return model.toJSON()
        case let .adBannerTapped(model):
            return model.toJSON()
        case let .authorizationSkipped(skipped):
            return ["is_skipped": skipped]
        case .authorizationPageViewed:
            return [:]
        case let .categoriesTapped(categoryName, sourceType):
            return ["category_name": categoryName, "source_type": sourceType.rawValue]
        case .mealPlannerPageViewed:
            return [:]
        case let .mealPlannerMealAdded(meal):
            return ["recipe_name": meal]
        case let .communityTapped(community):
            return ["community_name": community]
        case .searchByIngredientsViewed:
            return [:]
        case let .searchByIngredientsResult(products):
            return ["product_names": products.compactMap { $0.name }]
        case let .accountDeleted(user):
            return ["username": user?.username ?? "", "user_email": user?.email ?? ""]
        }
    }
}

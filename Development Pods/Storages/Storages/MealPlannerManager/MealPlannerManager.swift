//
//  MealPlannerManager.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import Foundation
import Models
import Extensions

public final class MealPlannerManager{
    // MARK: - Private properties

    private enum UserDefaultsKeys: String {
        case recipes = "apron.mealPlannerManager.mealPlannerRecipes"
    }

    private struct Observer {
        weak var object: AnyObject?
        let observer: (() -> Void)
    }

    private let userDefaults = UserDefaults.standard
    private var observers: [ObjectIdentifier: Observer] = [:]

    // MARK: - Public properties

    public static let shared = MealPlannerManager()

    // MARK: - Private init

    private init() {}

    // MARK: - Public subscribers

    public func subscribe(
        _ object: AnyObject,
        observer: @escaping (() -> Void)
    ) {
        let id = ObjectIdentifier(object)
        observers[id] = Observer(object: object, observer: observer)
    }

    public func unsubscribe(_ object: AnyObject) {
        let id = ObjectIdentifier(object)
        observers.removeValue(forKey: id)
    }

    // MARK: - Public methods

    public func update(
        for date: Date,
        with recipe: RecipeResponse
    ) {
        var currentItems = fetchItemsFromStorage()

        if let index = currentItems.firstIndex(where: {
            return ($0.recipeDate == date) && $0.recipeForDate.id == recipe.id
        }) {
            currentItems[index] = MealPlannerRecipe(
                recipeDate: date,
                recipeForDate: recipe
            )
            setItemsToStorage(items: currentItems)
            sendChangeEvent()
        } else {
            let item = MealPlannerRecipe(
                recipeDate: date,
                recipeForDate: recipe
            )
            addItemToStorage(item: item)
            sendChangeEvent()
        }

    }

    public func fetchItems() -> [MealPlannerRecipe] {
        return fetchItemsFromStorage()
    }

    public func fetchItemsByDate(_ date: Date) -> [MealPlannerRecipe] {
        let currentItems = fetchItemsFromStorage()
        return currentItems.filter { $0.recipeDate == date }
    }

    public func fetchItemsForRange(start: Date, end: Date) -> [MealPlannerRecipe] {
        let currentItems = fetchItemsFromStorage()
        let range = Date.dates(from: start, to: end)
        return currentItems.filter { range.contains($0.recipeDate) }
    }

    public func removeItem(for date: Date, with recipeId: Int) {
        var currentItems = fetchItemsFromStorage()
        let recipeIds = currentItems.map { $0.recipeForDate.id }
        currentItems.removeAll(where: { $0.recipeForDate.id == recipeId })
        setItemsToStorage(items: currentItems)
        sendChangeEvent()
    }

    public func resetMealPlanner() {
        clearStorage()
        sendChangeEvent()
    }

    // MARK: - Private methods

    private func sendChangeEvent() {
        observers.forEach { $0.value.observer() }
    }

    private func fetchItemsFromStorage() -> [MealPlannerRecipe] {
        guard let storageValue = userDefaults.value(forKey: UserDefaultsKeys.recipes.rawValue) as? Data else {
            return []
        }

        let decoder = JSONDecoder()
        guard let items = try? decoder.decode([MealPlannerRecipe].self, from: storageValue) else {
            return []
        }

        return items
    }

    private func setItemsToStorage(items: [MealPlannerRecipe]) {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(items) {
            userDefaults.set(encoded, forKey: UserDefaultsKeys.recipes.rawValue)
        }
    }

    private func addItemToStorage(item: MealPlannerRecipe) {
        var items = fetchItemsFromStorage()
        items.append(item)
        setItemsToStorage(items: items)
    }

    private func clearStorage() {
        userDefaults.removeObject(forKey: UserDefaultsKeys.recipes.rawValue)
    }
}

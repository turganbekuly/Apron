//
//  CartManager.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Foundation
import Models
import Extensions

public final class CartManager {
    // MARK: - Private properties

    private enum UserDefaultsKeys: String {
        case products = "apron.cartManager.cartProducts"
    }

    private struct Observer {
        weak var object: AnyObject?
        let observer: (() -> Void)
    }

    private struct ProductObserver {
        weak var object: AnyObject?
        let productName: String
        let observer: (() -> Void)
    }

    private let userDefaults = UserDefaults.standard
    private var observers: [ObjectIdentifier: Observer] = [:]
    private var productObservers: [ObjectIdentifier: ProductObserver] = [:]

    // MARK: - Public properties

    public static let shared = CartManager()

    // MARK: - Private init

    private init() {}

    // MARK: - Public methods

    public func subscribe(
        _ object: AnyObject,
        observer: @escaping (() -> Void)
    ) {
        let id = ObjectIdentifier(object)
        observers[id] = Observer(object: object, observer: observer)
    }

    public func subscribe(
        _ object: AnyObject,
        productName: String,
        observer: @escaping (() -> Void)
    ) {
        let id = ObjectIdentifier(object)
        productObservers[id] = ProductObserver(
            object: object,
            productName: productName,
            observer: observer
        )
    }

    public func unsubscribe(_ object: AnyObject) {
        let id = ObjectIdentifier(object)
        observers.removeValue(forKey: id)
        productObservers.removeValue(forKey: id)
    }

    // MARK: - Public methods

    public func itemsCount() -> Int {
        return fetchItemsFromStorage().map { $0.quantity }.reduce(0, +)
    }

    public func update(
        productName: String,
        amount: Double?,
        quantity: Int?,
        measurement: String?,
        recipeName: String?
    ){
        var currentItems = fetchItemsFromStorage()

        if let index = currentItems
            .firstIndex(where: {
                return ($0.productName == productName)
                && $0.measurement == measurement
            }) {
            let item = currentItems[index]

            if let quantity = quantity {
                if quantity > 0 {
                    currentItems[index] = CartItem(
                        productName: item.productName,
                        amount: (item.amount ?? 0) + (amount ?? 0),
                        quantity: item.quantity + quantity,
                        measurement: measurement,
                        recipeName: (item.recipeName ?? []) + [recipeName ?? ""]
                    )

                    setItemsToStorage(items: currentItems)
                    sendChangeEvent()
                    sendChangeEvent(productName: productName)
                } else {
                    removeItem(for: item.productName)
                }
            } else {
                currentItems[index] = CartItem(
                    productName: item.productName,
                    amount: amount,
                    quantity: item.quantity + 1,
                    measurement: measurement,
                    recipeName: (item.recipeName ?? []) + [recipeName ?? ""]
                )

                setItemsToStorage(items: currentItems)
                sendChangeEvent()
                sendChangeEvent(productName: productName)
            }
        } else {
            let item = CartItem(
                productName: productName,
                amount: amount,
                quantity: quantity ?? 1,
                measurement: measurement,
                recipeName: [recipeName ?? ""]
            )

            addItemToStorage(item: item)
            sendChangeEvent()
            sendChangeEvent(productName: productName)
        }
    }

    public func forceAdd(
        productName: String,
        amount: Double?,
        quantity: Int?,
        measurement: String?,
        recipeName: String?
    ) {
        let item = CartItem(
            productName: productName,
            amount: amount,
            quantity: quantity ?? 1,
            measurement: measurement,
            recipeName: [recipeName ?? ""]
        )

        addItemToStorage(item: item)
        sendChangeEvent()
        sendChangeEvent(productName: productName)
    }

    public func removeItems(productName: String) {
        var items = fetchItemsFromStorage()
        items.removeAll(where: {
            $0.productName.caseInsensitiveCompare(productName) == .orderedSame

        })
        setItemsToStorage(items: items)
        sendChangeEvent()
        sendChangeEvent(productName: productName)
    }

    public func removeItem(for carItemProductName: String) {
        var currentItems = fetchItemsFromStorage()
        let productIds = currentItems.map { $0.productName }
        currentItems.removeAll(where: {
            $0.productName.caseInsensitiveCompare(carItemProductName) == .orderedSame

        })
        setItemsToStorage(items: currentItems)
        sendChangeEvent()
        productIds.unique().forEach { sendChangeEvent(productName: $0) }
    }

    public func resetCart() {
        clearStorage()
        sendChangeEvent()
    }

    public func isContains(cartItem name: String) -> Bool {
        let items = fetchItemsFromStorage()
        return items.contains(where: {
            $0.productName.caseInsensitiveCompare(name) == .orderedSame
        })
    }

    public func fetchItems() -> [CartItem] {
        return fetchItemsFromStorage()
    }

    public func fetchItems(productName: String) -> [CartItem] {
        let currentItems = fetchItemsFromStorage()
        return currentItems.filter {
            $0.productName.caseInsensitiveCompare(productName) == .orderedSame
        }
    }

    public func getRecipeSources(for productName: String) -> [String] {
        guard let item = fetchItemsFromStorage().first(where: { $0.productName == productName }) else {
            return []
        }

        return item.recipeName ?? []
    }

    // MARK: - Private methods

    private func sendChangeEvent() {
        observers.forEach { $0.value.observer() }
    }

    private func sendChangeEvent(productName: String) {
        productObservers.forEach {
            if $0.value.productName == productName {
                $0.value.observer()
            }
        }
    }

    private func fetchItemsFromStorage() -> [CartItem] {
        guard let storageValue = userDefaults.value(forKey: UserDefaultsKeys.products.rawValue) as? Data else {
            return []
        }

        let decoder = JSONDecoder()
        guard let items = try? decoder.decode([CartItem].self, from: storageValue) else {
            return []
        }

        return items
    }

//    private func generateNewIdentifierForItem() -> Int {
//        let items = fetchItemsFromStorage()
//
//        if items.isEmpty {
//            return 0
//        } else {
//            guard let lastId = items.last?.id else { return 0 }
//            return lastId + 1
//        }
//    }

    private func setItemsToStorage(items: [CartItem]) {
        let encoder = JSONEncoder()

        if let encoded = try? encoder.encode(items) {
            userDefaults.set(encoded, forKey: UserDefaultsKeys.products.rawValue)
        }
    }

    private func addItemToStorage(item: CartItem) {
        var items = fetchItemsFromStorage()
        items.append(item)
        setItemsToStorage(items: items)
    }

    private func clearStorage() {
        userDefaults.removeObject(forKey: UserDefaultsKeys.products.rawValue)
    }
}

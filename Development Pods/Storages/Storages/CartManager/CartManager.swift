//
//  CartManager.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import Foundation
import Models

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
        let productId: Int
        let observer: (() -> Void)
    }

    private let userDefaults = UserDefaults.standard
    private var observers: [ObjectIdentifier: Observer] = [:]
    private var productObservers: [ObjectIdentifier: ProductObserver] = [:]

    // MARK: - Public properties

    static let shared = CartManager()

    // MARK: - Private init

    private init() {}

    // MARK: - Public methods

    func subscribe(
        _ object: AnyObject,
        observer: @escaping (() -> Void)
    ) {
        let id = ObjectIdentifier(object)
        observers[id] = Observer(object: object, observer: observer)
    }

    func subscribe(
        _ object: AnyObject,
        productId: Int,
        observer: @escaping (() -> Void)
    ) {
        let id = ObjectIdentifier(object)
        productObservers[id] = ProductObserver(
            object: object,
            productId: productId,
            observer: observer
        )
    }

    func unsubscribe(_ object: AnyObject) {
        let id = ObjectIdentifier(object)
        observers.removeValue(forKey: id)
        productObservers.removeValue(forKey: id)
    }

    // MARK: - Private methods

    private func sendChangeEvent() {
        observers.forEach { $0.value.observer() }
    }

    private func sendChangeEvent(productId: Int) {
        productObservers.forEach {
            if $0.value.productId == productId {
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

    private func generateNewIdentifierForItem() -> Int {
        let items = fetchItemsFromStorage()

        if items.isEmpty {
            return 0
        } else {
            guard let lastId = items.last?.id else { return 0 }
            return lastId + 1
        }
    }

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

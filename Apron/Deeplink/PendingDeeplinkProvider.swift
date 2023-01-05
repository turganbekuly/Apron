//
//  PendingDeeplinkProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

import Foundation
import AppsFlyerLib

protocol DeeplinkHandler: AnyObject {
    func handleDeeplink(with url: URL)
    func handleAFDeeplink(with deeplink: DeepLink)
}

protocol PendingDeeplinkProvider: AnyObject {
    var delegate: PendingDeeplinkProviderDelegate? { get set }
    var pendingDeeplink: CustomDeepLink? { get set }
}

protocol PendingDeeplinkProviderDelegate: AnyObject {
    func pendingDeeplinkProvider(_ provider: PendingDeeplinkProvider, didChangePendingDeeplink deeplink: CustomDeepLink?)
}

final class PendingDeeplinkProviderImpl: PendingDeeplinkProvider {

    // MARK: - PendingDeeplinkProvider

    weak var delegate: PendingDeeplinkProviderDelegate?

    var pendingDeeplink: CustomDeepLink? {
        didSet {
            guard oldValue != pendingDeeplink else { return }

            delegate?.pendingDeeplinkProvider(self, didChangePendingDeeplink: pendingDeeplink)
        }
    }
}

extension PendingDeeplinkProviderImpl: DeeplinkHandler {

    // MARK: - DeeplinkHandler

    func handleAFDeeplink(with deeplink: DeepLink) {
        pendingDeeplink = DeeplinkFactory().makeAppsflyerDeeplink(with: deeplink)
    }

    func handleDeeplink(with url: URL) {
        pendingDeeplink = DeeplinkFactory().makeDeeplink(from: url)
    }
}

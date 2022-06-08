//
//  PendingDeeplinkProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

import Foundation

protocol DeeplinkHandler: AnyObject {
    func handleDeeplink(with url: URL)
}

protocol PendingDeeplinkProvider: AnyObject {
    var delegate: PendingDeeplinkProviderDelegate? { get set }
    var pendingDeeplink: Deeplink? { get set }
}

protocol PendingDeeplinkProviderDelegate: AnyObject {
    func pendingDeeplinkProvider(_ provider: PendingDeeplinkProvider, didChangePendingDeeplink deeplink: Deeplink?)
}

final class PendingDeeplinkProviderImpl: PendingDeeplinkProvider {

    // MARK: - PendingDeeplinkProvider

    weak var delegate: PendingDeeplinkProviderDelegate?

    var pendingDeeplink: Deeplink? {
        didSet {
            guard oldValue != pendingDeeplink else { return }

            delegate?.pendingDeeplinkProvider(self, didChangePendingDeeplink: pendingDeeplink)
        }
    }

}

extension PendingDeeplinkProviderImpl: DeeplinkHandler {

    // MARK: - DeeplinkHandler

    func handleDeeplink(with url: URL) {
        pendingDeeplink = DeeplinkFactory().makeDeeplink(from: url)
    }
}

//
//  DeeplinkServicesContainer.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.06.2022.
//

final class DeeplinkServicesContainer {

    static let shared = DeeplinkServicesContainer()

    var deeplinkHandler: DeeplinkHandler {
        pendingDeeplinkProviderImpl
    }

    var pendingDeeplinkProvider: PendingDeeplinkProvider {
        pendingDeeplinkProviderImpl
    }

    private let pendingDeeplinkProviderImpl = PendingDeeplinkProviderImpl()
}

//
//  ApronAnalytics.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.05.2022.
//

import Foundation
import Amplitude
import FirebaseAnalytics
import Mixpanel
import AppsFlyerLib

protocol AnalyticsProtocol {
    func configure(
        amplitudeKey: String,
        mixpanelKey: String,
        appsFlyerKey: String,
        appsFlyerAppId: String
    )
    func sendAnalyticsEvent(_ event: AnalyticsEvents)
    func setupUserInfo(id: Int?, name: String?, email: String?)
    func resetAnalytics()
}

final class ApronAnalytics: AnalyticsProtocol {
    // MARK: - Properties

    public static let shared = ApronAnalytics()

    // MARK: - Init

    public init() {}

    // MARK: - Methods

    func configure(
        amplitudeKey: String,
        mixpanelKey: String,
        appsFlyerKey: String,
        appsFlyerAppId: String
    ) {
        Amplitude.instance().initializeApiKey(amplitudeKey)
        Mixpanel.initialize(token: mixpanelKey, trackAutomaticEvents: true)
        AppsFlyerLib.shared().appsFlyerDevKey = appsFlyerKey
        AppsFlyerLib.shared().appleAppID = appsFlyerAppId
        AppsFlyerLib.shared().resolveDeepLinkURLs = ["clicks.moca.kz"]
    }

    func sendAnalyticsEvent(_ event: AnalyticsEvents) {
        Amplitude.instance().logEvent(event.name, withEventProperties: event.eventProperties)
        Analytics.logEvent(event.name, parameters: event.eventProperties)

        var mixpanelAttributes: [String: MixpanelType] = [:]
        for property in event.eventProperties {
            mixpanelAttributes[property.key] = "\(property.value)"
        }

        Mixpanel.mainInstance().track(
            event: event.name,
            properties: mixpanelAttributes
        )

        Analytics.logEvent(event.name, parameters: event.eventProperties)
        AppsFlyerLib.shared().logEvent(event.name, withValues: event.eventProperties)
    }

    func setupUserInfo(id: Int?, name: String?, email: String?) {
        Amplitude.instance().setUserId(name)
        Amplitude.instance().setUserProperties(
            [
                "user_name": name ?? "",
                "user_email": email ?? ""
            ]
        )
        Analytics.setUserProperty(name, forName: "user_name")
        Analytics.setUserProperty(email, forName: "user_email")
        Mixpanel.mainInstance().identify(distinctId: "\(id ?? 0)")
        Mixpanel.mainInstance().people.set(property: "$name", to: name)
        Mixpanel.mainInstance().people.set(property: "$email", to: email)
        AppsFlyerLib.shared().customData = ["id": id ?? 0, "name": name ?? "", "email": email ?? ""]
    }

    func resetAnalytics() {
        DispatchQueue.global(qos: .background).async {
            Mixpanel.mainInstance().reset()
        }
    }
}

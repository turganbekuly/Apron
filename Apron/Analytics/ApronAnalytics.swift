//
//  ApronAnalytics.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.05.2022.
//

import Amplitude
import Foundation
import FirebaseAnalytics
import Mixpanel

protocol AnalyticsProtocol {
    func configure(
        amplitudeKey: String,
        mixpanelKey: String
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

    func configure(amplitudeKey: String, mixpanelKey: String) {
        Amplitude.instance().initializeApiKey(amplitudeKey)
        Mixpanel.initialize(token: mixpanelKey, trackAutomaticEvents: true)

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
        Mixpanel.mainInstance().people.set(property: "user_name", to: name)
        Mixpanel.mainInstance().people.set(property: "user_email", to: email)

    }

    func resetAnalytics() {
        DispatchQueue.global(qos: .background).async {
            Mixpanel.mainInstance().reset()
        }
    }
}

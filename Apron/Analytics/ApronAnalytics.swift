//
//  ApronAnalytics.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.05.2022.
//

import Amplitude
import Foundation

protocol AnalyticsProtocol {
    func configure(
        amplitudeKey: String,
        appsflyerDevKey: String,
        appleAppID: String
    )
    func sendAmplitudeEvent(_ event: AnalyticsEvents)
    func sendAppsflyerEvent(_ event: AnalyticsEvents)
    func setupUserInfo(name: String?, email: String?)
    func start()
}

final class ApronAnalytics: AnalyticsProtocol {
    // MARK: - Properties

    public static let shared = ApronAnalytics()

    // MARK: - Init

    public init() {}

    // MARK: - Methods

    func configure(amplitudeKey: String, appsflyerDevKey: String, appleAppID: String) {
        Amplitude.instance().initializeApiKey(amplitudeKey)
//        AppsFlyerLib.shared().appsFlyerDevKey = appsflyerDevKey
//        AppsFlyerLib.shared().appleAppID = appleAppID
    }

    func sendAmplitudeEvent(_ event: AnalyticsEvents) {
        Amplitude.instance().logEvent(event.name, withEventProperties: event.eventProperties)
    }

    func sendAppsflyerEvent(_ event: AnalyticsEvents) {
//        AppsFlyerLib.shared().logEvent(event.name, withValues: event.eventProperties)
    }

    func setupUserInfo(name: String?, email: String?) {
        Amplitude.instance().setUserId(name)
        Amplitude.instance().setUserProperties(
            [
                "user_name": name ?? "",
                "user_email": email ?? ""
            ]
        )
//        AppsFlyerLib.shared().customerUserID = userID
    }

    func start() {
//        AppsFlyerLib.shared().start()
    }
}

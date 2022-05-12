//
//  AnalyticsEventProtocol.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.05.2022.
//

import Foundation

protocol AnalyticsEventProtocol {
    var name: String { get }
    var eventProperties: [String: Any] { get }
}

//
//  ApplicationConfiguratorProtocol.swift
//  Pods-Apron
//
//  Created by Akarys Turganbekuly on 28.12.2021.
//

import Foundation

public protocol ApplicationConfiguratorProtocol {
    func configure(_ application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
}

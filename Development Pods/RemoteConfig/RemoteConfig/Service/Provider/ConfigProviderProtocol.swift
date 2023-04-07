//
//  ConfigProviderProtocol.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 04.02.2023.
//

import Foundation

public protocol ConfigProviderProtocol {
    func fetch(_ completion: @escaping ([String: Any]) -> Void)
}

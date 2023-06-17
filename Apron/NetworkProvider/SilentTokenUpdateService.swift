//
//  SilentTokenUpdateService.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 12.06.2023.
//

import Foundation
import Storages

final class SilentTokenUpdateService {
    // MARK: - Properties
    
    private let provider: AKNetworkProvider<SplashScreenEndpoints>
    
    // MARK: - Init
    
    init() {
        self.provider = AKNetworkProvider<SplashScreenEndpoints>()
    }
    
    // MARK: - Methods
    
    func updateToken(
        completion: @escaping ((AKResult) -> Void)
    ) {
        if let token = AuthStorage.shared.refreshToken {
            provider.send(target: .updateToken(refreshToken: token)) { result in
                completion(result)
            }
        }
    }
}

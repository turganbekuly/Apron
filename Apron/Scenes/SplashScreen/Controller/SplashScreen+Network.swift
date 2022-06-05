//
//  SplashScreen+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import Foundation

extension SplashScreenViewController {
    func updateToken(with token: String) {
        interactor.updateToken(request: .init(token: token))
    }
}

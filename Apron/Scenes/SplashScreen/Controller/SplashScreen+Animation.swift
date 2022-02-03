//
//  SplashScreen+Animation.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.01.2022.
//

import Foundation

extension SplashScreenViewController: ISplashScreenView {
    func animationDidFinished() {
        let vc = TabBarBuilder(state: .initial(.normal)).build()
//        let vc = AuthorizationBuilder(state: .initial).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

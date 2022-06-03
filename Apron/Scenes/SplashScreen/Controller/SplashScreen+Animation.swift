//
//  SplashScreen+Animation.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.01.2022.
//

import Foundation
import UIKit

extension SplashScreenViewController: ISplashScreenView {
    func animationDidFinished() {
        let vc = AuthorizationBuilder(state: .initial).build()
        let navVc = UINavigationController(rootViewController: vc)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(navVc, animated: true)
        }
    }
}

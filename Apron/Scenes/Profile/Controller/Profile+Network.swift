//
//  Profile+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

extension ProfileViewController {
    
    // MARK: - Network

    func getProfile() {
        interactor.getProfile(request: .init())
    }
}
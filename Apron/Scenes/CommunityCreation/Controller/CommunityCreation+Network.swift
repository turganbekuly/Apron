//
//  CommunityCreation+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension CommunityCreationViewController {

    // MARK: - Network

    func createCommunity(with model: CommunityCreation?) {
        guard let model = model else {
            return
        }

        interactor.createCommunity(request: .init(communityCreation: model))
    }

    func uploadImage(with image: UIImage) {
        interactor.uploadImage(request: .init(image: image))
    }
}

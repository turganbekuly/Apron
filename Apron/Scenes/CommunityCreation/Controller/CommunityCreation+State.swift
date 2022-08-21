//
//  CommunityCreation+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Configurations

extension CommunityCreationViewController {
    
    // MARK: - State
    public enum State {
        case initial(CommunityCreationInitialState)
        case communityCreationSucceed(CommunityResponse)
        case communityCreationFailed(AKNetworkError)
        case uploadImageSucceed(String)
        case uploadImageFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState):
            self.initialState = initialState
        case let .communityCreationSucceed(community):
            sendCommunityCreatedAnalytics(community: community)
            let vc = AddSavedRecipesBuilder(state: .initial(.communityCreation(community.id))).build()
            dismiss(animated: true) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .communityCreationFailed:
            show(type: .error("Произошла ошибка при создании"), firstAction: nil, secondAction: nil)
        case let .uploadImageSucceed(path):
            communityCreation?.imageURL = Configurations.downloadImageURL(imagePath: path)
            configureImageCell(isLoaded: false)
            replaceImageCell(type: .image)
        case .uploadImageFailed:
            configureImageCell(isLoaded: false)
            show(type: .error("Не удалось загрузить фото, попробуйте еще раз"))
        }
    }
    
}

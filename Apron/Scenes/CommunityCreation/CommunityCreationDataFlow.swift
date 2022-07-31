//
//  CommunityCreationDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

enum CommunityCreationDataFlow {
    
}

extension CommunityCreationDataFlow {
    enum CreateCommunity {
        struct Request {
            let communityCreation: CommunityCreation
        }
        struct Response {
            let result: CommunityCreationResult
        }
        struct ViewModel {
            var state: CommunityCreationViewController.State
        }
    }

    enum CommunityCreationResult {
    case successful(model: CommunityResponse)
    case failed(error: AKNetworkError)
    }
}

extension CommunityCreationDataFlow {
    enum UploadImage {
        struct Request {
            let image: UIImage
        }
        struct Response {
            let result: UploadImageResult
        }
        struct ViewModel {
            var state: CommunityCreationViewController.State
        }
    }

    enum UploadImageResult {
        case successful(imagePath: String)
        case failed(error: AKNetworkError)
    }
}

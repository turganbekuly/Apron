//
//  AddCommentDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import Models

enum AddCommentResultType: String {
    case success = "SUCCESS"
    case failed = "ERROR"
}

enum AddCommentDataFlow {}

extension AddCommentDataFlow {
    enum AddComment {
        struct Request {
            let body: AddCommentRequestBody
        }
        struct Response {
            let result: AddCommentResult
        }
        struct ViewModel {
            var state: AddCommentViewController.State
        }
    }

    enum AddCommentResult {
        case successful(result: AddCommentResultType)
        case failed(error: AKNetworkError)
    }
}

extension AddCommentDataFlow {
    enum UploadImage {
        struct Request {
            let image: UIImage
        }
        struct Response {
            let result: UploadImageResult
        }
        struct ViewModel {
            var state: AddCommentViewController.State
        }
    }

    enum UploadImageResult {
        case successful(imagePath: String)
        case failed(error: AKNetworkError)
    }
}

extension AddCommentDataFlow {
    enum RateRecipe {
        struct Request {
            let body: RatingRequestBody
        }
        struct Response {
            let result: RateRecipeResult
        }
        struct ViewModel {
            var state: AddCommentViewController.State
        }
    }

    enum RateRecipeResult {
        case successful(model: RatingResponse)
        case failed(error: AKNetworkError)
    }
}

//
//  InstructionSelectionDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum InstructionSelectionDataFlow {}

extension InstructionSelectionDataFlow {
    enum UploadImage {
        struct Request {
            let image: UIImage
        }
        struct Response {
            let result: UploadImageResult
        }
        struct ViewModel {
            var state: InstructionSelectionViewController.State
        }
    }

    enum UploadImageResult {
        case successful(imagePath: String)
        case failed(error: AKNetworkError)
    }
}

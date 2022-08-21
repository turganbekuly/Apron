//
//  InstructionSelectionPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol InstructionSelectionPresentationLogic: AnyObject {
    func uploadImage(response: InstructionSelectionDataFlow.UploadImage.Response)
}

final class InstructionSelectionPresenter: InstructionSelectionPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: InstructionSelectionDisplayLogic?
    
    // MARK: - InstructionSelectionPresentationLogic

    func uploadImage(response: InstructionSelectionDataFlow.UploadImage.Response) {
        DispatchQueue.main.async {
            var viewModel: InstructionSelectionDataFlow.UploadImage.ViewModel

            defer { self.viewController?.displayUploadedImage(with: viewModel) }

            switch response.result {
            case let .successful(imagePath):
                viewModel = .init(state: .uploadImageSucceed(imagePath))
            case let .failed(error):
                viewModel = .init(state: .uploadImageFailed(error))
            }
        }
    }
}

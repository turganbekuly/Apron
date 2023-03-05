//
//  InstructionSelection+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension InstructionSelectionViewController: InstructionSelectionDisplayLogic {

    // MARK: - InstructionSelectionDisplayLogic

    func displayUploadedImage(with viewModel: InstructionSelectionDataFlow.UploadImage.ViewModel) {
        state = viewModel.state
    }
}

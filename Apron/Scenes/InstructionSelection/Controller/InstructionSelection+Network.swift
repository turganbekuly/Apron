//
//  InstructionSelection+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension InstructionSelectionViewController {
    
    // MARK: - Network

    func uploadImage(with image: UIImage) {
        interactor.uploadImage(request: .init(image: image))
    }
}

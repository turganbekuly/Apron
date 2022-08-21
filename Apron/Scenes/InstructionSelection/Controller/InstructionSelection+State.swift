//
//  InstructionSelection+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Configurations

extension InstructionSelectionViewController {
    
    // MARK: - State
    public enum State {
        case initial(Int, InstructionSelectedProtocol)
        case uploadImageSucceed(String)
        case uploadImageFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(stepCount, delegate):
            self.stepCount = stepCount
            self.delegate = delegate
            sections = [.init(section: .instructions, rows: [.placeholder, .description])]
        case let .uploadImageSucceed(path):
            instruction.image = Configurations.downloadImageURL(imagePath: path)
            configureImageCell(isLoaded: false)
            replaceImageCell(type: .image)
        case .uploadImageFailed:
            configureImageCell(isLoaded: false)
            show(type: .error("Не удалось загрузить фото, попробуйте еще раз"))
        }
    }
    
}

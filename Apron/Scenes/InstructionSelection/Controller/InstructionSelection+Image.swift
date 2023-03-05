//
//  InstructionSelection+Image.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.04.2022.
//

import UIKit

extension InstructionSelectionViewController: RecipeCreationPlaceholderImageCellProtocol {
    func chooseImageDidTapped() {
        openMediaModal()
    }
}

extension InstructionSelectionViewController: RecipeCreationImageCellProtocol {
    func editPhoto() {
        openMediaModal()
    }

    func deletePhoto() {
        replaceImageCell(type: .placeholder)
    }
}

extension InstructionSelectionViewController {
    func replaceImageCell(type: ImageCellType) {
        switch type {
        case .image:
            guard let section = sections.firstIndex(where: { $0.section == .instructions }),
                  let placeholderRow = sections[section].rows.firstIndex(where: { $0 == .placeholder }) else { return }

            mainView.beginUpdates()
            mainView.deleteRows(at: [.init(row: placeholderRow, section: section)], with: .fade)
            sections[section].rows.remove(at: placeholderRow)

            mainView.insertRows(at: [.init(row: 0, section: section)], with: .fade)
            sections[section].rows.insert(.image, at: 0)
            mainView.endUpdates()
        case .placeholder:
            guard let section = sections.firstIndex(where: { $0.section == .instructions }),
                  let imageRow = sections[section].rows.firstIndex(where: { $0 == .image }) else { return }

            mainView.beginUpdates()
            mainView.deleteRows(at: [.init(row: imageRow, section: section)], with: .fade)
            sections[section].rows.remove(at: imageRow)

            mainView.insertRows(at: [.init(row: 0, section: section)], with: .fade)
            sections[section].rows.insert(.placeholder, at: 0)
            mainView.endUpdates()
        }
    }
}

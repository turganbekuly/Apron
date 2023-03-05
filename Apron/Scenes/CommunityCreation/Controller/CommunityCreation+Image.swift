//
//  CommunityCreation+Image.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.05.2022.
//

import UIKit

extension CommunityCreationViewController: RecipeCreationPlaceholderImageCellProtocol {
    func chooseImageDidTapped() {
        openMediaModal()
    }
}

extension CommunityCreationViewController: RecipeCreationImageCellProtocol {
    func editPhoto() {
        openMediaModal()
    }

    func deletePhoto() {
        replaceImageCell(type: .placeholder)
    }
}

extension CommunityCreationViewController {
    func replaceImageCell(type: ImageCellType) {
        switch type {
        case .image:
            guard let section = sections.firstIndex(where: { $0.section == .info }),
                  let nameRow = sections[section].rows.firstIndex(where: { $0 == .name }),
                  let placeholderRow = sections[section].rows.firstIndex(where: { $0 == .imagePlaceholder }) else { return }

            mainView.beginUpdates()
            mainView.deleteRows(at: [.init(row: placeholderRow, section: section)], with: .fade)
            sections[section].rows.remove(at: placeholderRow)

            mainView.insertRows(at: [.init(row: nameRow + 1, section: section)], with: .fade)
            sections[section].rows.insert(.image, at: nameRow + 1)
            mainView.endUpdates()
        case .placeholder:
            guard let section = sections.firstIndex(where: { $0.section == .info }),
                  let nameRow = sections[section].rows.firstIndex(where: { $0 == .name }),
                  let imageRow = sections[section].rows.firstIndex(where: { $0 == .image }) else { return }

            mainView.beginUpdates()
            mainView.deleteRows(at: [.init(row: imageRow, section: section)], with: .fade)
            sections[section].rows.remove(at: imageRow)

            mainView.insertRows(at: [.init(row: nameRow + 1, section: section)], with: .fade)
            sections[section].rows.insert(.imagePlaceholder, at: nameRow + 1)
            mainView.endUpdates()
        }
    }
}

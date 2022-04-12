//
//  RecipeCreation+Image.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.04.2022.
//

import UIKit

extension RecipeCreationViewController {
    func replacePlaceholderCell() {
        guard let section = sections.firstIndex(where: { $0.section == .info }),
              let nameRow = sections[section].rows.firstIndex(where: { $0 == .name }),
              let placeholderRow = sections[section].rows.firstIndex(where: { $0 == .imagePlaceholder }) else { return }

        mainView.beginUpdates()
        mainView.deleteRows(at: [.init(row: placeholderRow, section: section)], with: .fade)
        sections[section].rows.remove(at: placeholderRow)

        mainView.insertRows(at: [.init(row: nameRow + 1, section: section)], with: .fade)
        sections[section].rows.insert(.image, at: nameRow + 1)
        mainView.reloadData()
        mainView.endUpdates()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.replaceImageCell()
        }
    }

    func replaceImageCell() {
        guard let section = sections.firstIndex(where: { $0.section == .info }),
              let nameRow = sections[section].rows.firstIndex(where: { $0 == .name }),
              let imageRow = sections[section].rows.firstIndex(where: { $0 == .image }) else { return }

        mainView.beginUpdates()
        mainView.deleteRows(at: [.init(row: imageRow, section: section)], with: .fade)
        sections[section].rows.remove(at: imageRow)

        mainView.insertRows(at: [.init(row: nameRow + 1, section: section)], with: .fade)
        sections[section].rows.insert(.imagePlaceholder, at: nameRow + 1)
        mainView.reloadData()
        mainView.endUpdates()
    }
}

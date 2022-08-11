//
//  AddComment+Image.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.08.2022.
//

extension AddCommentViewController: RecipeCreationPlaceholderImageCellProtocol {
    func chooseImageDidTapped() {
        openMediaModal()
    }
}

extension AddCommentViewController: RecipeCreationImageCellProtocol {
    func editPhoto() {
        openMediaModal()
    }

    func deletePhoto() {
        replaceImageCell(type: .placeholder)
    }
}

extension AddCommentViewController {
    func replaceImageCell(type: ImageCellType) {
        switch type {
        case .image:
            guard let section = sections.firstIndex(where: { $0.section == .comment }),
                  let nameRow = sections[section].rows.firstIndex(where: { $0 == .rate }),
                  let placeholderRow = sections[section].rows.firstIndex(where: { $0 == .placeholder }) else { return }

            mainView.beginUpdates()
            mainView.deleteRows(at: [.init(row: placeholderRow, section: section)], with: .fade)
            sections[section].rows.remove(at: placeholderRow)

            mainView.insertRows(at: [.init(row: nameRow + 1, section: section)], with: .fade)
            sections[section].rows.insert(.image, at: nameRow + 1)
            mainView.endUpdates()
        case .placeholder:
            guard let section = sections.firstIndex(where: { $0.section == .comment }),
                  let nameRow = sections[section].rows.firstIndex(where: { $0 == .rate }),
                  let imageRow = sections[section].rows.firstIndex(where: { $0 == .image }) else { return }

            mainView.beginUpdates()
            mainView.deleteRows(at: [.init(row: imageRow, section: section)], with: .fade)
            sections[section].rows.remove(at: imageRow)

            mainView.insertRows(at: [.init(row: nameRow + 1, section: section)], with: .fade)
            sections[section].rows.insert(.placeholder, at: nameRow + 1)
            mainView.endUpdates()
        }
    }
}



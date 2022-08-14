//
//  AddComment+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension AddCommentViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .rate:
            let cell: EmojiCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .image:
            let cell: RecipeCreationImageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .placeholder:
            let cell: RecipeCreationPlaceholderImageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .note:
            let cell: RecipeCreationDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .tags:
            let cell: TagsCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension AddCommentViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .rate:
            return 100
        case .image:
            return 221
        case .placeholder:
            return 167
        case .note:
            return 125
        case .tags:
            return 400
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .rate:
            return 100
        case .image:
            return 221
        case .placeholder:
            return 167
        case .note:
            return 125
        case .tags:
            return 400
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .rate:
            guard let cell = cell as? EmojiCell else { return }
            cell.delegate = self
            cell.configure()
        case .placeholder:
            guard let cell = cell as? RecipeCreationPlaceholderImageCell else { return }
            cell.delegate = self
            cell.configure()
        case .image:
            guard let cell = cell as? RecipeCreationImageCell else { return }
            cell.delegate = self
            cell.configure(image: selectedImage, imageURL: addCommentRequestBody?.image)
        case .note:
            guard let cell = cell as? RecipeCreationDescriptionCell else { return }
            cell.placeholder = "Расскажите о своем опыте. Любые советы по улучшению этого рецепта?"
            cell.delegate = self
            cell.configure(description: "")
        case .tags:
            guard let cell = cell as? TagsCell else { return }
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.configure()
        }
    }
}

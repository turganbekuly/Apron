//
//  RecipeCreation+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension RecipeCreationViewController: UITableViewDataSource {
    
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
        case .image:
            let cell: RecipeCreationImageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .description:
            let cell: RecipeCreationDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .composition:
            let cell: RecipeCreationAddIngredients = tableView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            let cell: RecipeCreationNamingCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension RecipeCreationViewController: UITableViewDelegate {
    
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
        case .name:
            return 54
        case .image:
            return 167
        case .description:
            return 125
        case .composition:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .name:
            return 54
        case .image:
            return 167
        case .description:
            return 125
        case .composition:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .name:
            guard let cell = cell as? RecipeCreationNamingCell else { return }
            cell.configure()
        case .image:
            guard let cell = cell as? RecipeCreationImageCell else { return }
            cell.configure()
        case .description:
            guard let cell = cell as? RecipeCreationDescriptionCell else  { return }
            cell.configure()
        case .composition:
            guard let cell = cell as? RecipeCreationAddIngredients else { return }
            cell.configure()
        default: break
        }
    }
}

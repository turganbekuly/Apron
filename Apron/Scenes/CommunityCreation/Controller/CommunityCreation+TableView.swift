//
//  CommunityCreation+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension CommunityCreationViewController: UITableViewDataSource {
    
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
        case .name:
            let cell: CommunityCreationNamingCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .image:
            let cell: RecipeCreationImageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .imagePlaceholder:
            let cell: RecipeCreationPlaceholderImageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .description:
            let cell: CommunityCreationDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .category:
            let cell: CommunityCreationCategoryCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .privacy:
            let cell: CommunityCreationPrivacyCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .permission:
            let cell: CommunityCreationPermissionsCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        default:
            let cell: UITableViewCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension CommunityCreationViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .category:
            let viewController = CategorySelectionBuilder(state: .initial(self)).build()
            DispatchQueue.main.async {
                self.navigationController?.presentPanModal(viewController)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .name:
            return 85
        case .image:
            return 221
        case .imagePlaceholder:
            return 167
        case .description:
            return 125
        case .category:
            return 85
        case .privacy:
            return 130
        case .permission:
            return 130
        default:
            return 600
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .name:
            return 85
        case .image:
            return 221
        case .imagePlaceholder:
            return 167
        case .description:
            return 125
        case .category:
            return 85
        case .privacy:
            return 130
        case .permission:
            return 130
        default:
            return 600
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .name:
            guard let cell = cell as? CommunityCreationNamingCell else { return }
            cell.delegate = self
            cell.configure(recipeName: communityCreation?.communityName)
        case .description:
            guard let cell = cell as? CommunityCreationDescriptionCell else { return }
            cell.delegate = self
            cell.configure(description: communityCreation?.description)
        case .imagePlaceholder:
            guard let cell = cell as? RecipeCreationPlaceholderImageCell else { return }
            cell.delegate = self
            cell.configure()
        case .image:
            guard let cell = cell as? RecipeCreationImageCell else { return }
            cell.delegate = self
            cell.configure(image: selectedImage, imageURL: communityCreation?.imageURL)
        case .category:
            guard let cell = cell as? CommunityCreationCategoryCell else { return }
            cell.configure(with: communityCreation?.category)
        case .privacy:
            guard let cell = cell as? CommunityCreationPrivacyCell else { return }
            cell.delegate = self
            cell.configure(isHidden: communityCreation?.isHidden ?? true)
        case .permission:
            guard let cell = cell as? CommunityCreationPermissionsCell else { return }
            cell.delegate = self
            cell.configure(isEdiatable: !(communityCreation?.privateAdding ?? true))
        default:
            break
        }
    }
}

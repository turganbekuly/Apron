//
//  InstructionSelection+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import APRUIKit

extension InstructionSelectionViewController: UITableViewDataSource {

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
        case .placeholder:
            let cell: RecipeCreationPlaceholderImageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .image:
            let cell: RecipeCreationImageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .description:
            let cell: RecipeCreationDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension InstructionSelectionViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .image:
            return 221
        case .placeholder:
            return 240
        case .description:
            return 125
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .image:
            return 221
        case .placeholder:
            return 240
        case .description:
            return 125
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .placeholder:
            guard let cell = cell as? RecipeCreationPlaceholderImageCell else { return }
            cell.delegate = self
            cell.configure()
        case .image:
            guard let cell = cell as? RecipeCreationImageCell else { return }
            cell.delegate = self
            cell.configure(imageURL: instruction.image)
        case .description:
            guard let cell = cell as? RecipeCreationDescriptionCell else { return }
            cell.placeholder = L10n.InstructionSelection.Description.cellPlaceholder
            cell.delegate = self
            cell.configure(description: instruction.description)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        case .instructions:
            let view: InstructionSelectionHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .instructions:
            return 54
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .instructions:
            return 54
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .instructions:
            guard let view = view as? InstructionSelectionHeaderView else { return }
            view.configure(title: "Шаг №\(stepCount)")
        }
    }
}
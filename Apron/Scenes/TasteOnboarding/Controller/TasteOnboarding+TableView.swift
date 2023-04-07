//
//  TasteOnboarding+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension TasteOnboardingViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .option:
            let cell: TasteOnboardingCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension TasteOnboardingViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .option(option):
            guard let cell = tableView.cellForRow(at: indexPath) as? TasteOnboardingCell else { return }
            if cell.checkbox.checkState == .checked {
                switch tasteOnboardingTypes {
                case .vegan:
                    tasteOnboardingModel?.vegan.append(option)
                case .ingredients:
                    tasteOnboardingModel?.ingredients.append(option)
                case .cuisine:
                    tasteOnboardingModel?.cuisine.append(option)
                default: break
                }
            }
        }
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]

        switch row {
        case let .option(option):
            guard let cell = tableView.cellForRow(at: indexPath) as? TasteOnboardingCell else { return }
            if cell.checkbox.checkState == .unchecked {
                switch tasteOnboardingTypes {
                case .vegan:
                    tasteOnboardingModel?.vegan = ""
                case .ingredients:
                    tasteOnboardingModel?.ingredients.removeAll(where: { item in
                        item == option
                    })
                case .cuisine:
                    tasteOnboardingModel?.cuisine.removeAll(where: { item in
                        item == option
                    })
                default: break
                }
            }
        }
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .option:
            return 45
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .option:
            return 45
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .option(option):
            guard let cell = cell as? TasteOnboardingCell else { return }
            cell.configure(with: TasteOnboardingViewModel(text: option, type: tasteOnboardingTypes ?? .vegan))
        }
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section: TasteOnboardingViewController.Section.Section = sections[section].section
        switch section {
        case .options:
            let view: TasteOnboardingHeaderCell = tableView.dequeueReusableHeaderFooterView()
            return view
        }
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section: TasteOnboardingViewController.Section.Section = sections[section].section
        switch section {
        case .options:
            return 36
        }
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section: TasteOnboardingViewController.Section.Section = sections[section].section
        switch section {
        case .options:
            return 36
        }
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section: TasteOnboardingViewController.Section.Section = sections[section].section
        switch section {
        case let .options(title):
            guard let view = view as? TasteOnboardingHeaderCell else { return }
            view.configure(with: TasteOnboardingHeaderViewModel(title: title))
        }
    }
}

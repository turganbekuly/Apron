//
//  Profile+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import Storages
import RemoteConfig
import AlertMessages
import APRUIKit

extension ProfileViewController: UITableViewDataSource {

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
        case .user:
            let cell: ProfileUserCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .logout, .deleteAccount, .contactWithDevelopers, .myRecipes:
            let cell: ProfileItemsCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .assistant:
            let cell: ProfileAssistantCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }

}

extension ProfileViewController: UITableViewDelegate {

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .logout:
            AuthStorage.shared.clear()
            ApronAnalytics.shared.resetAnalytics()
            self.navigationController?.popToRootViewController(animated: true)
            let vc = AuthorizationBuilder(state: .initial).build()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(navVC, animated: true)
            }
        case .myRecipes:
            let vc = MyRecipesBuilder(state: .initial(state: .profile)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .deleteAccount:
            let confirm = AlertActionInfo(
                title: L10n.Common.yes,
                type: .normal,
                action: {
                    let id: Int = self.userStorage.user?.id ?? 0
                    self.deleteAccount(with: id)
                }
            )
            
            let cancel = AlertActionInfo(
                title: L10n.Common.no,
                type: .destructive,
                action: { }
            )

            showAlert(
                L10n.Profile.DeleteAccount.Alert.title,
                message: L10n.Profile.DeleteAccount.Alert.message,
                actions: [confirm, cancel]
            )
        case .contactWithDevelopers:
            let link = RemoteConfigManager.shared.remoteConfig.contactWithDevelopersLink
            guard !link.isEmpty else { return }
            let webViewController = WebViewHandler(urlString: link)
            presentPanModal(webViewController)
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .user:
            return 131
        case .logout, .assistant, .deleteAccount, .contactWithDevelopers, .myRecipes:
            return 56
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .user:
            return 131
        case .logout, .assistant, .deleteAccount, .contactWithDevelopers, .myRecipes:
            return 56
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .user:
            guard let cell = cell as? ProfileUserCell else { return }

            cell.delegate = self
            cell.configure(with: ProfileUserCellViewModel(user: userStorage.user))
        case .assistant:
            guard let cell = cell as? ProfileAssistantCell else { return }

            cell.configure(with: ProfileItemsCellViewModel(row: row, mode: .center))
        case .deleteAccount:
            guard let cell = cell as? ProfileItemsCell else { return }
            cell.configure(with: ProfileItemsCellViewModel(row: row, mode: .center))
        case .contactWithDevelopers:
            guard let cell = cell as? ProfileItemsCell else { return }
            cell.configure(with: ProfileItemsCellViewModel(row: row, mode: .center))
        case .myRecipes:
            guard let cell = cell as? ProfileItemsCell else { return }
            cell.configure(with: ProfileItemsCellViewModel(row: row, mode: .center))
        case .logout:
            guard let cell = cell as? ProfileItemsCell else { return }

            cell.configure(with: ProfileItemsCellViewModel(row: row, mode: .bottom))
        }
    }
}

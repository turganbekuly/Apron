//
//  Profile+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import Storages

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
        case .logout, .about, .deleteAccount:
            let cell: ProfileItemsCell = tableView.dequeueReusableCell(for: indexPath)
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
            let vc = AuthorizationBuilder(state: .initial).build()
            vc.hidesBottomBarWhenPushed = true
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .deleteAccount:
            let id: Int = userStorage.user?.id ?? 0
            deleteAccount(with: id)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .user:
            return 131
        case .logout, .about, .deleteAccount:
            return 56
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .user:
            return 131
        case .logout, .about, .deleteAccount:
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
        case .about:
            guard let cell = cell as? ProfileItemsCell else { return }

            cell.configure(with: ProfileItemsCellViewModel(row: row, mode: .top))
        case .deleteAccount:
            guard let cell = cell as? ProfileItemsCell else { return }
            
            cell.configure(with: ProfileItemsCellViewModel(row: row, mode: .center))
        case .logout:
            guard let cell = cell as? ProfileItemsCell else { return }

            cell.configure(with: ProfileItemsCellViewModel(row: row, mode: .bottom))
        }
    }
}

//
//  CommunitiesList+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension CommunitiesListViewController: UITableViewDataSource {
    
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
        case .community:
            let cell: GeneralSearchCommunityCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
}

extension CommunitiesListViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .community(community):
            let viewController = CommunityPageBuilder(state: .initial(community.id)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .community:
            return 72
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .community:
            return 72
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section].section
        switch section {
        case .communities:
            switch initialState {
            case .myCommunities:
                let view: CommunityListHeaderView = tableView.dequeueReusableHeaderFooterView()
                return view
            default:
                return nil
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .communities:
            switch initialState {
            case .myCommunities:
                return 30
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .communities:
            switch initialState {
            case .myCommunities:
                return 30
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case .communities:
            switch initialState {
            case .myCommunities:
                guard let view = view as? CommunityListHeaderView else { return }
                view.configure()
            default:
                break
            }
        }
    }
}

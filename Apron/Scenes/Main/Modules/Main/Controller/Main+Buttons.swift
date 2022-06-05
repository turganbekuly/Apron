//
//  Main+Buttons.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import UIKit
import Storages

extension MainViewController: DynamicCommunityCellProtocol {
    func navigateToCommunity(with id: Int) {
        handleAuthorizationStatus { [weak self] in
            guard let self = self else { return }
            let vc = CommunityPageBuilder(state: .initial(id)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    func navigateToSeeAll(with categoryID: Int, title: String) {
        let vc = CommunitiesListBuilder(state: .initial(.all(id: categoryID, name: title))).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainViewController: MyCommunityCellProtocol {
    func navigateToMyCommunity(with id: Int) {
        handleAuthorizationStatus { [weak self] in
            guard let self = self else { return }
            let vc = CommunityPageBuilder(state: .initial(id)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    func navigateToSeeAll() {
        let vc = CommunitiesListBuilder(state: .initial(.myCommunities)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

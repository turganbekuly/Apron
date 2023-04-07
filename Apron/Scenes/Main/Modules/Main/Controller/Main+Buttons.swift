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
        let vc = CommunityPageBuilder(state: .initial(.fromMain(id: id))).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func navigateToSeeAll(with categoryID: Int, title: String) {}
}

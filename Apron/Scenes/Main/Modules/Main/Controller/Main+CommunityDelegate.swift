//
//  Main+CommunityDelegate.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 14.08.2023.
//

import Foundation

extension MainViewController: CommunityCellProtocol {
    func navigateToCommunity(with id: Int) {
        let vc = CommunityPageBuilder(state: .initial(.fromMain(id: id))).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    func navigateToSeeAll(with categoryID: Int, title: String) { }
}

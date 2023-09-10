//
//  Main+SBIMainDelegate.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 10.09.2023.
//

import UIKit

extension MainViewController: SBIMainTableCellDelegate {
    func sbiProductSelected() {
        let vc = SearchByIngredientsBuilder(state: .initial).build()
        vc.hidesBottomBarWhenPushed = true
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}

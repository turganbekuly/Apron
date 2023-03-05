//
//  UITableView+ReloadData.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 22.04.2022.
//

import UIKit

extension UITableView {
    public func reloadTableViewWithoutAnimation() {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }
}

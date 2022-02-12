//
//  RecipePage+SegmentedControl.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.02.2022.
//

import Foundation

extension RecipePageViewController: ISegmentedHeader {
    func trackSelectedIndex(_ selectedIndex: Int) {
        self.pagerViewController.setFirst(index: selectedIndex)
    }
}

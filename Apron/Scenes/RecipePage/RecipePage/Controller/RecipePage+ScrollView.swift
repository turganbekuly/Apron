//
//  RecipePage+ScrollView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28.01.2022.
//

import Foundation
import UIKit

extension RecipePageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        handleScrollForTabs(contentOffset: scrollView.contentOffset.y, contentInset: scrollView.contentInset.top)
    }

    func handleScrollForTabs(contentOffset: CGFloat, contentInset: CGFloat) {
        let trueOffset = contentOffset + contentInset

        let min = abs(
            min(
                -stackView.frame.height + mainView.frame.height + view.safeAreaInsets.top,
                 -trueOffset
            )
        )
        delta = -stackView.frame.height + mainView.frame.height + view.safeAreaInsets.top + min
        stackView.frame.origin.y = -stackView.frame.height + delta
    }
}

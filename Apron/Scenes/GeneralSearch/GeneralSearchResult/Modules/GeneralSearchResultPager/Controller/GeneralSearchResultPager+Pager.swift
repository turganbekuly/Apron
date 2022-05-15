//
//  GeneralSearchResultPager+Pager.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import Extensions
import UIKit

extension GeneralSearchResultPagerViewController: UIPageViewControllerDataSource {

    // MARK: - UIPageViewControllerDataSource
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allViewControllers.firstIndex(of: viewController),
            let controller = allViewControllers[safe: index - 1] else { return nil }

        return controller
    }

    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allViewControllers.firstIndex(of: viewController),
            let controller = allViewControllers[safe: index + 1] else { return nil }

        return controller
    }

}

extension GeneralSearchResultPagerViewController: UIPageViewControllerDelegate {

    // MARK: - UIPageViewControllerDelegate
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first,
              let index = allViewControllers.firstIndex(of: viewController) else {
            return
        }

        selectedIndex = index
        pagerDelegate?.controller(self, didSelectIndex: index)
    }

}


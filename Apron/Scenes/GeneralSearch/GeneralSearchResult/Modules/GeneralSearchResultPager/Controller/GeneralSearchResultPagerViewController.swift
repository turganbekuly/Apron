//
//  GeneralSearchResultPagerViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import APRUIKit
import UIKit

protocol GeneralSearchResultPagerViewControllerDelegate: AnyObject {
    func controller(_ controller: GeneralSearchResultPagerViewController, didSelectIndex index: Int)
}

final class GeneralSearchResultPagerViewController: PageViewController {

    // MARK: - Properties
    weak var selectionDelegate: ResultListViewControllerDelegate?
    weak var pagerDelegate: GeneralSearchResultPagerViewControllerDelegate?
    var state: State {
        didSet {
            updateState()
        }
    }

    var query: String? {
        didSet {
            allViewControllers.forEach { viewController in
                guard let vc = viewController as? ResultListViewController else { return }
                vc.query = query
            }
        }
    }
    
    var pages = [GeneralSearchInitialState]() {
        didSet {
            selectedIndex = pages.firstIndex(of: currentPage) ?? 0
            allViewControllers = pages.compactMap {
                ResultListBuilder(state: .initial($0, query, selectionDelegate)).build()
            }
        }
    }
    var currentPage: GeneralSearchInitialState = .recipe
    var allViewControllers = [UIViewController]() {
        didSet {
            setInitialViewController()
        }
    }
    var selectedIndex = 0

    // MARK: - Init
    init(state: State) {
        self.state = state

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
    }

    // MARK: - Methods
    func setFirst(index: Int) {
        guard let viewController = allViewControllers[safe: index] else {
            return
        }

        setViewControllers([viewController],
                           direction: index < selectedIndex ? .reverse : .forward,
                           animated: true) { [weak self] _ in
            self?.dataSource = self
            self?.delegate = self
            self?.selectedIndex = index
        }
    }

    func setInitialViewController() {
        guard let viewController = allViewControllers[safe: selectedIndex] else {
            return
        }

        setViewControllers([viewController],
                           direction: .forward,
                           animated: false) { [weak self] _ in
            self?.dataSource = self
            self?.delegate = self
        }
    }

    deinit {
        NSLog("deinit \(self)")
    }

}

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

public protocol GeneralSearchResultPagerViewControllerDelegate: AnyObject {
    func controller(_ controller: GeneralSearchResultPagerViewController, didSelectIndex index: Int)
}

public final class GeneralSearchResultPagerViewController: PageViewController {

    // MARK: - Properties
    public weak var pagerDelegate: GeneralSearchResultPagerViewControllerDelegate?
    public var state: State {
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
    
    public var pages = [GeneralSearchInitialState]() {
        didSet {
            selectedIndex = pages.firstIndex(of: currentPage) ?? 0
            allViewControllers = pages.compactMap {
                ResultListBuilder(state: .initial($0, query)).build()
            }
        }
    }
    public var currentPage: GeneralSearchInitialState = .everything
    public var allViewControllers = [UIViewController]() {
        didSet {
            setInitialViewController()
        }
    }
    public var selectedIndex = 0

    // MARK: - Init
    public init(state: State) {
        self.state = state

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle
    override public func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
    }

    // MARK: - Methods
    public func setFirst(index: Int) {
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

    public func setInitialViewController() {
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

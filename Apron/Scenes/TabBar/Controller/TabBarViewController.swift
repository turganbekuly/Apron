//
//  TabBarViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Protocols

public protocol TabBarDisplayLogic: AnyObject {
    
}

public final class TabBarViewController: AppTabBarController {
    // MARK: - Properties

    public var state: State {
        didSet {
            updateState()
        }
    }

    public enum ViewControllerTypes {
        case main
        case saved
        case list
        case planner
    }

    private lazy var mainModule = MainBuilder(state: .initial).build()
    private lazy var favouriteModule = MainBuilder(state: .initial).build()
    private lazy var listModule = MainBuilder(state: .initial).build()
    private lazy var plannerModule = MainBuilder(state: .initial).build()

    // MARK: - Init
    
    public init(state: State) {
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        state = { state }()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods

    public func configureTabBar() {

        viewControllers = [
            configureViewController(viewController: mainModule, type: .main),
            configureViewController(viewController: favouriteModule, type: .saved),
            configureViewController(viewController: listModule, type: .list),
            configureViewController(viewController: plannerModule, type: .planner)
        ]
    }

    private func configureViewController(viewController: UIViewController, type: ViewControllerTypes) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        switch type {
        case .main:
            navigationController.tabBarItem.title = "Главная"
            navigationController.tabBarItem.image = Assets.tabHomeSelectedIcon.image
        case .saved:
            navigationController.tabBarItem.title = "Избранное"
            navigationController.tabBarItem.image = Assets.tabFaveSelectedIcon.image
        case .list:
            navigationController.tabBarItem.title = "Список"
            navigationController.tabBarItem.image = Assets.tabListSelectedIcon.image
        case .planner:
            navigationController.tabBarItem.title = "Планнер"
            navigationController.tabBarItem.image = Assets.tabPlannerSelectedIcon.image
        }
        return navigationController
    }

    private func configureColors() {
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}

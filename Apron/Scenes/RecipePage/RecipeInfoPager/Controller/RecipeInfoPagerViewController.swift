//
//  RecipeInfoPagerViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import Models
import DesignSystem
import UIKit

protocol IRecipeInfoPagerViewController: AnyObject {
    func controller(_ controller: RecipeInfoPagerViewController, didSelectIndex index: Int)
}

final class RecipeInfoPagerViewController: PageViewController {

    // MARK: - Properties

    weak var pagerDelegate: IRecipeInfoPagerViewController?
    var state: State {
        didSet {
            updateState()
        }
    }

    var pages = [RecipeInitialState]() {
        didSet {
            selectedIndex = pages.firstIndex(of: currentPage) ?? 0
            allViewControllers = pages.compactMap {
                switch $0 {
                case .ingredients:
                    let vc = IngredientsPageBuilder(state: .initial).build()
                    return vc
                case .instruction:
                    let vc = InstructionsPageBuilder(state: .initial).build()
                    return vc
                case .calories:
                    let vc = InstructionsPageBuilder(state: .initial).build()
                    return vc
                }
            }
        }
    }

    var currentPage: RecipeInitialState = .ingredients
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
        nil
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
    }

    // MARK: - Methods

    func setFirst(index: Int) {
        guard let viewController = allViewControllers[safe: index] else {
            return
        }

        setViewControllers(
            [viewController],
            direction: index < selectedIndex ? .reverse : .forward,
            animated: true
        ) { [weak self] _ in
            self?.dataSource = self
            self?.delegate = self
            self?.selectedIndex = index
        }
    }

    func setInitialViewController() {
        guard let viewController = allViewControllers[safe: selectedIndex] else {
            return
        }

        setViewControllers(
            [viewController],
            direction: .forward,
            animated: false
        ) { [weak self] _ in
            self?.dataSource = self
            self?.delegate = self
        }
    }

    deinit {
        NSLog("deinit \(self)")
    }

}

final class ASDViewController: UIViewController {
    var backgroundColor: UIColor

    init(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
    }
}

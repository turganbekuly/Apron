//
//  SavedRecipesViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import UIScrollView_InfiniteScroll
import SnapKit
import HapticTouch

protocol SavedRecipesDisplayLogic: AnyObject {
    func displaySavedRecipes(with viewModel: SavedRecipesDataFlow.GetSavedRecipe.ViewModel)
}

final class SavedRecipesViewController: ViewController {

    struct Section {
        enum Section {
            case recipes
        }
        enum Row {
            case recipe(RecipeResponse)
            case empty
            case loading
        }

        var section: Section
        var rows: [Row]
    }

    // MARK: - Properties

    weak var outputDelegate: SavedRecipeOutputModule?

    var initialState: SavedRecipesInitialState? {
        didSet {
            switch initialState {
            case let .mealPlanner(delegate):
                self.outputDelegate = delegate
            default:
                break
            }
        }
    }

    let interactor: SavedRecipesBusinessLogic

    lazy var sections: [Section] = [
        .init(section: .recipes, rows: Array(repeating: .loading, count: 10))
    ]
    var state: State {
        didSet {
            updateState()
        }
    }

    var savedRecipes: [RecipeResponse] = []
    var currentPage = 1

    private var navigationTitleHeight: Constraint?

    // MARK: - Views
    lazy var mainView: SavedRecipesView = {
        let view = SavedRecipesView()
        view.dataSource = self
        view.delegate = self
        view.refreshControl = refreshControl
        return view
    }()

    public lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return view
    }()

    private lazy var navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = APRAssets.primaryTextMain.color
        label.textAlignment = .center
        label.text = L10n.SavedRecipes.SavedRecipes.title
        return label
    }()

    // MARK: - Init
    init(interactor: SavedRecipesBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()

        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigation()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    private func configureNavigation() {
        guard let navigation = navigationController else {
            navigationTitleHeight?.update(offset: 30)
            return
        }

        let avatarView = AvatarView()
        avatarView.onTap = { [weak self] in
            guard let self = self else { return }
            self.handleAuthorizationStatus {
                let viewController = ProfileBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    navigation.pushViewController(viewController, animated: false)
                }
            }
        }

        let cartView = CartButtonView()
        cartView.onTap = {
            let viewController = ShoppingListBuilder(state: .initial(.regular)).build()

            DispatchQueue.main.async {
                navigation.pushViewController(viewController, animated: false)
            }
        }
        
        let bonusView = BonusView()
        bonusView.onBonusButtonTapped = { [weak self] in
            let vc = WebViewHandler(urlString: AppConstants.bonusLink)
            DispatchQueue.main.async {
                self?.presentPanModal(vc)
            }
        }
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: cartView),
            UIBarButtonItem(customView: bonusView)
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigation.navigationBar.barTintColor = APRAssets.secondary.color
        navigation.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigation.navigationBar.shadowImage = UIImage()
    }

    private func configureViews() {
        [mainView, navigationTitleLabel].forEach { view.addSubview($0) }

        mainView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.getSavedRecipes(page: self.currentPage)
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        navigationTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview()
            navigationTitleHeight = $0.height.equalTo(0).constraint
        }

        mainView.snp.makeConstraints {
            $0.top.equalTo(navigationTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func refresh(_ sender: UIRefreshControl) {
        HapticTouch.generateLight()
        savedRecipes.removeAll()
        sections = [.init(section: .recipes, rows: Array(repeating: .loading, count: 10))]
        mainView.reloadData()
        currentPage = 1
        getSavedRecipes(page: currentPage)
    }

    deinit {
        NSLog("deinit \(self)")
    }

}

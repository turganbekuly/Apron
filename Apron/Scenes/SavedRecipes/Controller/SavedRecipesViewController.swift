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
        let avatarView = AvatarView()
        avatarView.onTap = { [weak self] in
            guard let self = self else { return }
            self.handleAuthorizationStatus {
                let viewController = ProfileBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }

        let cartView = CartButtonView()
        cartView.onTap = { [weak self] in
            let viewController = ShoppingListBuilder(state: .initial(.regular)).build()

            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(viewController, animated: false)
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartView)
        navigationController?.navigationBar.barTintColor = ApronAssets.secondary.color
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }

        mainView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.getSavedRecipes(page: self.currentPage)
        }

        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func refresh(_ sender: UIRefreshControl) {
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

//
//  MyRecipesViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import AlertMessages

protocol MyRecipesDisplayLogic: AnyObject {
    func displayProfileRecipes(with viewModel: MyRecipesDataFlow.GetMyRecipesData.ViewModel)
}

final class MyRecipesViewController: ViewController {
    // MARK: - Properties
    
    let interactor: MyRecipesBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    var recipes: [RecipeResponse] = [] {
        didSet {
            guard !recipes.isEmpty else {
                sections = [.init(section: .recipes, rows: [.empty])]
                mainView.reloadData()
                return
            }
            sections = [
                .init(
                    section: .recipes,
                    rows: recipes
                        .sorted(by: { $0.status ?? .declined < $1.status ?? .active })
                        .compactMap { .recipe($0) }
                )
            ]
            mainView.reloadData()
        }
    }
    
    // MARK: - Views
    lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return view
    }()

    lazy var mainView: MyRecipesView = {
        let view = MyRecipesView()
        view.dataSource = self
        view.delegate = self
        view.refreshControl = refreshControl
        return view
    }()
    
    // MARK: - Init
    init(interactor: MyRecipesBusinessLogic, state: State) {
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
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: ApronAssets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureColors() {
        
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }

    @objc
    private func refresh(_ sender: UIRefreshControl) {
        recipes.removeAll()
        sections = [
            .init(section: .recipes, rows: [.shimmer])
        ]
        mainView.reloadData()
        getProfileRecipes()
    }
    
}

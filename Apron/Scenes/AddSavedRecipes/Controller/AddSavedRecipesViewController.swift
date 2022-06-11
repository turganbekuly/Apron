//
//  AddSavedRecipesViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models

protocol AddSavedRecipesDisplayLogic: AnyObject {
    func displaySavedRecipes(with viewModel: AddSavedRecipesDataFlow.GetSavedRecipe.ViewModel)
    func displayCommunityRecipes(with viewModel: AddSavedRecipesDataFlow.AddToCommunity.ViewModel)
}

final class AddSavedRecipesViewController: ViewController {
    
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
    let interactor: AddSavedRecipesBusinessLogic
    var sections: [Section] = [
        .init(section: .recipes, rows: Array(repeating: .loading, count: 10))
    ]
    var state: State {
        didSet {
            updateState()
        }
    }

    var savedRecipes: [RecipeResponse] = []
    var currentPage = 1
    var selectedRecipes: [Int] = [] {
        didSet {
            if selectedRecipes.isEmpty {
                saveButton.backgroundType = .whiteBackground
                saveButton.setTitle("Пропустить", for: .normal)
            } else {
                saveButton.backgroundType = .blackBackground
                saveButton.setTitle("Добавить", for: .normal)
            }
        }
    }

    var initialState: AddSavedRecipesType? {
        didSet {
            switch initialState {
            case let .community(id):
                self.communityID = id
            default:
                break
            }
        }
    }

    var communityID = 0
    
    // MARK: - Views

    lazy var saveButton: BlackOpButton = {
        let button = BlackOpButton(
            backgroundType: .whiteBackground,
            arrowState: .none,
            frame: CGRect(x: 0, y: 0, width: 90, height: 30)
        )
        button.setTitle("Пропустить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить рецепт"
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(
            ApronAssets.navBackButton.image
                .withTintColor(.black),
            for: .normal
        )
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var leftButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    lazy var mainView: AddSavedRecipesView = {
        let view = AddSavedRecipesView()
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
    init(interactor: AddSavedRecipesBusinessLogic, state: State) {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButtonStackView)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
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
        sections = [.init(section: .recipes, rows: Array(repeating: .loading, count: 10))]
        mainView.reloadData()
        currentPage = 1
        getSavedRecipes(page: currentPage)
    }

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func saveButtonTapped() {
        saveButton.setLoading(true)
        addToCommunity(communityID: communityID, recipes: selectedRecipes)
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}

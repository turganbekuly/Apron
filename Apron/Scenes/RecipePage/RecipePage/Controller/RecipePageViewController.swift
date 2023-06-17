//
//  RecipePageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import AlertMessages
import OneSignal
import HapticTouch

protocol RecipePageDisplayLogic: AnyObject {
    func displayRecipe(viewModel: RecipePageDataFlow.GetRecipe.ViewModel)
    func displayRating(viewModel: RecipePageDataFlow.RateRecipe.ViewModel)
    func displaySaveRecipe(viewModel: RecipePageDataFlow.SaveRecipe.ViewModel)
    func displayComments(viewModel: RecipePageDataFlow.GetComments.ViewModel)
}

final class RecipePageViewController: ViewController {
    // MARK: - Properties
    
    let interactor: RecipePageBusinessLogic
    
    var sections: [Section] = []
    
    var selectedIndexPath = IndexPath(row: .zero, section: .zero)
    var pages: [RecipeInitialState] = [.ingredients, .instruction, .calories]
    
    var state: State {
        didSet {
            updateState()
        }
    }
    
    var initialState: RecipeCreationSourceTypeModel?
    
    var recipe: RecipeResponse? {
        didSet {
            var localSections = [Section]()
            if let recipe = recipe {
                ApronAnalytics.shared.sendAnalyticsEvent(
                    .recipePageViewed(
                        RecipePageViewedModel(
                            recipeID: recipe.id,
                            recipeName: recipe.recipeName ?? "",
                            sourceType: initialState ?? .community,
                            isSaved: recipe.isSaved ?? false
                        )
                    )
                )
                
                configureSave(isSaved: recipe.isSaved ?? false)
            }
            if recipe?.status == .declined {
                localSections.append(.init(section: .reworkInfo, rows: [.reworkInfo]))
            }
            localSections.append(
                contentsOf:
                    [
                        .init(section: .topView, rows: [.topView]),
                        .init(section: .description, rows: [.description]),
                        .init(section: .ingredients, rows: [.ingredient]),
                        //                        .init(section: .nutritions, rows: [.nutrition]),
                        .init(section: .instructions, rows: [.instruction]),
                        .init(section: .reviews, rows: recipeComments.compactMap { .review($0) })
                    ]
            )
            self.sections = localSections
            mainView.reloadData()
        }
    }
    
    var recipeComments: [RecipeCommentResponse] = [] {
        didSet {
            var localSections = [Section]()
            guard let recipe = recipe, !recipeComments.isEmpty else { return }
            if recipe.status == .declined {
                localSections.append(.init(section: .reworkInfo, rows: [.reworkInfo]))
            }
            localSections.append(
                contentsOf:
                    [
                        .init(section: .topView, rows: [.topView]),
                        .init(section: .description, rows: [.description]),
                        .init(section: .ingredients, rows: [.ingredient]),
                        //                        .init(section: .nutritions, rows: [.nutrition]),
                        .init(section: .instructions, rows: [.instruction]),
                        .init(section: .reviews, rows: recipeComments.compactMap { .review($0) })
                    ]
            )
            self.sections = localSections
            mainView.reloadData()
        }
    }
    
    var recipeId = 0
    
    // MARK: - Views factory
    
    lazy var mainView: RecipePageView = {
        let view = RecipePageView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    lazy var bottomStickyView: RecipeBottomStickyView = {
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        $0.layer.cornerRadius = 15
        $0.delegate = self
        $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        $0.layer.shadowOffset = CGSize(width: 4, height: -5)
        $0.layer.shadowOpacity = 0.6
        $0.layer.shadowRadius = 15
        return $0
    }(RecipeBottomStickyView())
    
    private lazy var editBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: APRAssets.recipeEditIcon.image,
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        return button
    }()
    
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: APRAssets.favoriteIcon24.image,
            style: .plain,
            target: self,
            action: #selector(saveRecipeTapped)
        )
        button.tintColor = APRAssets.primaryTextMain.color
        return button
    }()
    
    private lazy var shareBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: APRAssets.recipeShareIcon.image,
            style: .plain,
            target: self,
            action: #selector(shareRecipeTapped)
        )
        button.tintColor = APRAssets.primaryTextMain.color
        return button
    }()
    
    // MARK: - Init
    init(interactor: RecipePageBusinessLogic, state: State) {
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
    
    // MARK: - Setup Views
    
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: APRAssets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = APRAssets.secondary.color
        if initialState == .myRecipes {
            editBarButtonItem.tintColor = APRAssets.primaryTextMain.color
            navigationItem.rightBarButtonItems = [shareBarButtonItem, editBarButtonItem, saveBarButtonItem]
            return
        }
        navigationItem.rightBarButtonItems = [shareBarButtonItem, saveBarButtonItem]
    }
    
    private func configureViews() {
        [mainView, bottomStickyView].forEach { view.addSubview($0) }
        mainView.contentInset.bottom += 100
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        bottomStickyView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(160)
        }
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }
    
    func configureSave(isSaved: Bool) {
        HapticTouch.generateMedium()
        if isSaved {
            self.saveBarButtonItem.image = APRAssets.heartFilled24White.image
            return
        }
        
        self.saveBarButtonItem.image = APRAssets.heart24White.image
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
    private func editButtonTapped() {
        guard let recipe = recipe,
              let model = RecipeCreation(from: recipe )
        else { return }
        let vc = RecipeCreationBuilder(state: .initial(.edit(model, .recipePage))).build()
        let navController = RecipeCreationNavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        HapticTouch.generateSuccess()
        DispatchQueue.main.async {
            self.navigationController?.present(navController, animated: true)
        }
    }
    
    @objc
    private func saveRecipeTapped() {
        guard let recipe = recipe else { return }
        handleAuthorizationStatus { [weak self] in
            guard let self = self,
                  let isSaved = recipe.isSaved,
                  !isSaved
            else {
                self?.show(type: .error(L10n.SavedRecipes.AlreadyAdded.title))
                HapticTouch.generateError()
                return
            }
            
            self.saveRecipe(with: recipe.id)
        }
    }
    
    @objc
    private func shareRecipeTapped() {
        let viewController = UIActivityViewController(
            activityItems: [
                "Зацените рецепт \"\(self.recipe?.recipeName ?? "")\" на Moca.kz 👀\n moca.kz://main/recipe/\(self.recipe?.id ?? 0)"
            ],
            applicationActivities: nil
        )
        
        if let popoover = viewController.popoverPresentationController {
            popoover.sourceView = self.view
            popoover.sourceRect = self.view.bounds
            popoover.permittedArrowDirections = []
        }
        
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
}

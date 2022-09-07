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

protocol RecipePageDisplayLogic: AnyObject {
    func displayRecipe(viewModel: RecipePageDataFlow.GetRecipe.ViewModel)
    func displayRating(viewModel: RecipePageDataFlow.RateRecipe.ViewModel)
    func displaySaveRecipe(viewModel: RecipePageDataFlow.SaveRecipe.ViewModel)
    func displayComments(viewModel: RecipePageDataFlow.GetComments.ViewModel)
}

final class RecipePageViewController: ViewController, Messagable {
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
            if let recipe = recipe {
                ApronAnalytics.shared.sendAmplitudeEvent(
                    .recipePageViewed(
                        RecipePageViewedModel(
                            recipeID: recipe.id,
                            recipeName: recipe.recipeName ?? "",
                            sourceType: initialState ?? .community,
                            isSaved: recipe.isSaved ?? false
                        )
                    )
                )
                bottomStickyView.configure(isSaved: recipe.isSaved ?? false)
            }
            sections = [
                .init(section: .topView, rows: [.topView]),
                .init(section: .description, rows: [.description]),
                .init(section: .ingredients, rows: [.ingredient]),
//                .init(section: .nutritions, rows: [.nutrition]),
                .init(section: .instructions, rows: [.instruction]),
                .init(section: .reviews, rows: recipeComments.compactMap { .review($0) })
            ]
            mainView.reloadData()
        }
    }

    var recipeComments: [RecipeCommentResponse] = [] {
        didSet {
            guard let _ = recipe, !recipeComments.isEmpty else { return }
            sections = [
                .init(section: .topView, rows: [.topView]),
                .init(section: .description, rows: [.description]),
                .init(section: .ingredients, rows: [.ingredient]),
//                .init(section: .nutritions, rows: [.nutrition]),
                .init(section: .instructions, rows: [.instruction]),
                .init(section: .reviews, rows: recipeComments.compactMap { .review($0) })
            ]
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

    private lazy var bottomStickyView: RecipeBottomStickyView = {
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        $0.layer.cornerRadius = 15
        $0.delegate = self
        $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        $0.layer.shadowOffset = CGSize(width: 4, height: -5)
        $0.layer.shadowOpacity = 0.6
        $0.layer.shadowRadius = 15
        return $0
    }(RecipeBottomStickyView())
    
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
            image: ApronAssets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
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
        view.backgroundColor = ApronAssets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}

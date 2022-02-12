//
//  RecipePageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol RecipePageDisplayLogic: AnyObject {
    
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

    var topView = [
        RecipeInformationCellViewModel(
            recipeName: "Легкий грибной суп",
            recipeSubtitle: "в Вегетарианские рецепты и еще 2 сообществах",
            recipeSourceURL: "asdgamer1995123"
        )
    ]
    
    // MARK: - Views factory

    public lazy var pagerViewController: RecipeInfoPagerViewController = {
        guard
            let viewController = RecipeInfoPagerBuilder(state: .initial(pages, .ingredients)).build()
            as? RecipeInfoPagerViewController
        else {
            return RecipeInfoPagerViewController(state: .initial([], .ingredients))
        }

        viewController.pagerDelegate = self
        return viewController
    }()

    lazy var mainView: RecipePageView = {
        let view = RecipePageView()
        view.dataSource = self
        view.delegate = self
        return view
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
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Assets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = Assets.secondary.color
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() { }
}

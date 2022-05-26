//
//  RecipePageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Models
import AlertMessages

protocol RecipePageDisplayLogic: AnyObject {
    func displayRecipe(viewModel: RecipePageDataFlow.GetRecipe.ViewModel)
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

    var recipe: RecipeResponse? {
        didSet {
            sections = [
                .init(section: .topView, rows: [.topView]),
                .init(section: .description, rows: [.description]),
                .init(section: .ingredients, rows: [.ingredient]),
                .init(section: .nutritions, rows: [.nutrition]),
                .init(section: .instructions, rows: [.instruction])
            ]
            mainView.reloadData()
        }
    }
    
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
            image: Assets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = Assets.secondary.color
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
            $0.height.equalTo(100)
        }
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

    // MARK: - Private methods

    private func configureTopView() {
        guard let section = sections.firstIndex(where: { $0.section == .topView }),
              let row = sections[section].rows.firstIndex(where: { $0 == .topView }),
              let cell = mainView.cellForRow(at: .init(row: row, section: section)) as? RecipeInformationViewCell else { return }

        cell.configure(
            with: InformationCellViewModel(
            recipeName: recipe?.recipeName ?? "",
            recipeSourceURL: recipe?.sourceLink ?? ""
            )
        )
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}

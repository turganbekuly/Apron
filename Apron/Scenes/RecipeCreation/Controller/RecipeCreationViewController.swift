//
//  RecipeCreationViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol RecipeCreationDisplayLogic: AnyObject {
    
}

final class RecipeCreationViewController: ViewController {
    // MARK: - Properties
    let interactor: RecipeCreationBusinessLogic
    var sections: [Section] = [
        .init(
            section: .info,
            rows: [
                .name, .image, .description,
                .composition, .instruction, .servings,
                .prepTime, .cookTime
            ]
        )
    ]

    var ingredientSections: [IngredientSection] = []

    var ingredients: IngredientsListCellViewModel? {
        didSet {
            //
        }
    }

    var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views
    private lazy var saveButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle("Вступить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        return button
    }()

    lazy var mainView: RecipeCreationView = {
        let view = RecipeCreationView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: RecipeCreationBusinessLogic, state: State) {
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
        navigationController?.navigationBar.isHidden = true
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
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func saveButtonTapped() {

    }
}

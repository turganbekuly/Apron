//
//  RecipeCreationViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Models
import AlertMessages

protocol RecipeCreationDisplayLogic: AnyObject {
    func displayRecipe(viewModel: RecipeCreationDataFlow.CreateRecipe.ViewModel)
}

final class RecipeCreationViewController: ViewController, Messagable {
    // MARK: - Properties

    let interactor: RecipeCreationBusinessLogic

    // Sections

    var sections: [Section] = []

    var instructions: [String] = [] {
        didSet {
            recipeCreation?.instructions = instructions
            mainView.reloadTableViewWithoutAnimation()
        }
    }

    var recipeCreation: RecipeCreation?
    var recipeCommunityId = 0 {
        didSet {
            recipeCreation?.communityId = recipeCommunityId
        }
    }

    var recipeCreationSourceType: RecipeCreationSourceType? {
        didSet {
            switch recipeCreationSourceType {
            case let .community(id, delegate):
                self.delegate = delegate
                self.recipeCommunityId = id
            default:
                break
            }
        }
    }

    weak var delegate: CommunityPageCreateRecipeProtocol?

    var selectedImage: UIImage? {
        didSet {
            mainView.reloadTableViewWithoutAnimation()
            replaceImageCell(type: .image)
        }
    }

    // Initial state

    var initialState: RecipeCreationInitialState? {
        didSet {
            switch initialState {
            case let .create(recipeCreation, sourceType),
                let .edit(recipeCreation, sourceType):
                self.recipeCreation = recipeCreation
                self.recipeCreationSourceType = sourceType

                sections = [
                    .init(
                        section: .info,
                        rows: [
                            .name, .imagePlaceholder, .description,
                            .composition, .instruction, .servings,
                            .prepTime, .cookTime
                        ]
                    )
                ]
                mainView.reloadData()
            default:
                break
            }
        }
    }

    var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views factory

    lazy var saveButton: BlackOpButton = {
        let button = BlackOpButton(arrowState: .none, frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        button.setTitle("Сохранить", for: .normal)
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButtonStackView)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
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
        view.backgroundColor = ApronAssets.secondary.color
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
        recipeCreation?.imageURL = "djfaksdjfkasdfklasdf"
        recipeCreation?.sourceLink = "faskdfkasdfkasdf"
        recipeCreation?.sourceName = "asdfaskdfkasdfk"
        if let _ = recipeCreation?.recipeName,
           let _ = recipeCreation?.description,
           let _ = recipeCreation?.ingredients,
           let _ = recipeCreation?.instructions,
           let _ = recipeCreation?.servings,
           let _ = recipeCreation?.prepTime,
           let _ = recipeCreation?.cookTime
        {
            self.createRecipe(recipe: recipeCreation)
        } else {
            show(
                type: .dialog(
                "Обязательные поля!",
                "Пожалуйста, заполните все поля, чтобы остальным учасникам было все понятно. Спасибо!",
                "Понятно",
                "Заполнить"
            ),
                firstAction: nil,
                secondAction: nil
            )
        }
    }
}

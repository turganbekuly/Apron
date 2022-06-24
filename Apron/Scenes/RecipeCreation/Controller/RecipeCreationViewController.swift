//
//  RecipeCreationViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
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

    var analyticsSourceType: RecipeCreationSourceTypeModel? {
        didSet {
            ApronAnalytics.shared.sendAmplitudeEvent(
                .recipeCreationPageViewed(analyticsSourceType ?? .community)
            )
        }
    }

    var recipeCreationSourceType: RecipeCreationSourceType? {
        didSet {
            switch recipeCreationSourceType {
            case let .community(id, delegate):
                self.delegate = delegate
                self.recipeCommunityId = id
                analyticsSourceType = .community
            case .saved:
                analyticsSourceType = .saved
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

    private lazy var saveButton: NavigationButton = {
        let button = NavigationButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backButton = NavigationBackButton()

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
        backButton.configure(with: "Новый рецепт")
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        saveButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
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

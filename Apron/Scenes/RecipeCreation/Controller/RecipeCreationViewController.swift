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
import Storages
import AlertMessages

protocol RecipeCreationDisplayLogic: AnyObject {
    func displayRecipe(viewModel: RecipeCreationDataFlow.CreateRecipe.ViewModel)
    func displayUploadedImage(with viewModel: RecipeCreationDataFlow.UploadImage.ViewModel)
}

final class RecipeCreationViewController: ViewController, Messagable {
    // MARK: - Properties

    let interactor: RecipeCreationBusinessLogic

    // Sections

    var sections: [Section] = []

    var tagsSections: [TagsSection] = [
        .init(section: .whenToCook, rows: SuggestedCookingTime.allCases.compactMap { .option($0) })
    ]

    // Recipe creation model

    var recipeCreationStorage: RecipeCreationStorageProtocol = RecipeCreationStorage()
    var recipeCreation: RecipeCreation? {
        didSet {
            recipeCreationStorage.recipeCreation = recipeCreation
        }
    }

    var selectedOptions = [SuggestedCookingTime]() {
        didSet {
            recipeCreation?.whenToCook = selectedOptions.compactMap { $0.rawValue }
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
            case let .community(delegate):
                self.delegate = delegate
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
            if let selectedImage = selectedImage {
                uploadImage(with: selectedImage)
                configureImageCell(isLoaded: true)
            }
        }
    }

    // Initial state

    var initialState: RecipeCreationInitialState? {
        didSet {
            switch initialState {
            case let .create(recipeCreation, sourceType),
                let .edit(recipeCreation, sourceType):
                if let storeRecipeCreation = recipeCreationStorage.recipeCreation,
                    storeRecipeCreation.communityId == recipeCreation.communityId {
                    show(with: storeRecipeCreation)
                } else {
                    self.recipeCreation = recipeCreation
                }
                self.recipeCreationSourceType = sourceType
                sections = [
                    .init(
                        section: .info,
                        rows: [
                            .name, .imagePlaceholder,.source,
                            .description, .composition, .instruction,
                            .servings, .cookTime, .whenToCook
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

    func configureImageCell(isLoaded: Bool) {
        guard
            let section = sections.firstIndex(where: { $0.section == .info }),
            let row = sections[section].rows.firstIndex(of: .imagePlaceholder),
            let cell = mainView.cellForRow(at: IndexPath(row: row, section: section)) as? RecipeCreationPlaceholderImageCell
        else { return }
        if isLoaded {
            cell.startAnimating()
        } else {
            cell.stopAnimating()
        }
        mainView.reloadTableViewWithoutAnimation()
    }

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

    func configureInstructions() {
        guard
            let section = sections.firstIndex(where: { $0.section == .info }),
            let row = sections[section].rows.firstIndex(where: { $0 == .instruction }),
            let cell = mainView.cellForRow(at: IndexPath(row: row, section: section)) as? RecipeCreationAddInstructionCell
        else { return }
        cell.instructionsView.reloadData()
        mainView.reloadTableViewWithoutAnimation()
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    private func show(with recipe: RecipeCreation) {
        let confirm = AlertActionInfo(
            title: "Да",
            type: .normal,
            action: {
                self.recipeCreation = recipe
                self.mainView.reloadData()
                self.recipeCreationStorage.recipeCreation = nil
            }
        )
        let cancel = AlertActionInfo(
            title: "Нет",
            type: .cancel,
            action: {
                self.recipeCreationStorage.recipeCreation = nil
                self.mainView.reloadData()
            }
        )
        self.showAlert(
            "Продолжить создание рецепта?",
            message: "Вы недавно были в процессе создания рецепта. Вы хотите продолжить с того места, на котором остановились?",
            actions: [confirm, cancel]
        )
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        if let _ = recipeCreation?.recipeName,
           let _ = recipeCreation?.ingredients,
           let _ = recipeCreation?.instructions,
           let _ = recipeCreation?.servings,
           let _ = recipeCreation?.cookTime
        {
            guard let instructions = recipeCreation?.instructions else { return }
            for (index, item) in instructions.enumerated() {
                guard let itemIndex = recipeCreation?.instructions.firstIndex(where: { $0.description == item.description }) else { return }
                recipeCreation?.instructions[itemIndex].orderNo = index + 1
            }

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

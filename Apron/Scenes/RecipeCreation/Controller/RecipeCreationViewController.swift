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
import RemoteConfig
import HapticTouch

protocol RecipeCreationDisplayLogic: AnyObject {
    func displayRecipe(viewModel: RecipeCreationDataFlow.CreateRecipe.ViewModel)
    func displayUploadedImage(with viewModel: RecipeCreationDataFlow.UploadImage.ViewModel)
}

final class RecipeCreationViewController: ViewController {
    // MARK: - Properties

    let interactor: RecipeCreationBusinessLogic

    // Sections

    var sections: [Section] = []

    var tagsSections: [TagsSection] = [
        .init(section: .whenToCook, rows: SuggestedDayTimeType.allCases.compactMap { .whenToCook($0) }),
        .init(section: .dishType, rows: SuggestedDishType.allCases.compactMap { .dishType($0) }),
        .init(section: .lifeStyleType, rows: SuggestedLifestyleType.allCases.compactMap { .lifeStyleType($0) }),
        .init(section: .eventType, rows: SuggestedEventType.allCases.compactMap { .eventType($0) })
    ]

    // Recipe creation model

    var recipeCreationStorage: RecipeCreationStorageProtocol = RecipeCreationStorage()
    var recipeCreation: RecipeCreation? {
        didSet {
            switch initialState {
            case .create:
                recipeCreationStorage.recipeCreation = recipeCreation
            default:
                break
            }
        }
    }

    var selectedCookingTime = [SuggestedDayTimeType]() {
        didSet {
            recipeCreation?.whenToCook = selectedCookingTime.compactMap { $0.rawValue }
        }
    }
    var selectedDishTypes = [SuggestedDishType]() {
        didSet {
            recipeCreation?.dishType = selectedDishTypes.compactMap { $0.rawValue }
        }
    }
    var selectedLifestyleTypes = [SuggestedLifestyleType]() {
        didSet {
            recipeCreation?.lifestyleType = selectedLifestyleTypes.compactMap { $0.rawValue }
        }
    }
    var selectedEventTypes = [SuggestedEventType]() {
        didSet {
            recipeCreation?.occasion = selectedEventTypes.compactMap { $0.rawValue }
        }
    }

    var analyticsSourceType: RecipeCreationSourceTypeModel? {
        didSet {
            ApronAnalytics.shared.sendAnalyticsEvent(
                .recipeCreationPageViewed(analyticsSourceType ?? .community)
            )
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
            case let .create(recipeCreation, sourceType):
                if let storeRecipeCreation = recipeCreationStorage.recipeCreation {
                    show(with: storeRecipeCreation, initialRecipe: recipeCreation)
                }
                self.recipeCreation = recipeCreation
                self.analyticsSourceType = sourceType
                handleSections(with: recipeCreation)
            case let .edit(recipeCreation, sourceType):
                assignTagValues(recipeCreation: recipeCreation)
                self.recipeCreation = recipeCreation
                self.analyticsSourceType = sourceType
                handleSections(with: recipeCreation)
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
        button.backgroundType = .blackBackground
        button.setTitle(L10n.Common.Save.title, for: .normal)
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
        backButton.configure(with: L10n.RecipeCreation.NewRecipe.title)
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        navigationController?.navigationBar.backgroundColor = APRAssets.secondary.color
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
        view.backgroundColor = APRAssets.secondary.color
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

    func saveButtonLoader(isLoading: Bool) {
        if isLoading {
            saveButton.startAnimating()
            return
        }
        saveButton.stopAnimating()
    }

    // MARK: - Private methods

    private func show(with storageRecipe: RecipeCreation, initialRecipe: RecipeCreation) {
        let confirm = AlertActionInfo(
            title: L10n.Common.yes,
            type: .normal,
            action: {
                self.recipeCreation = storageRecipe
                self.handleSections(with: storageRecipe)
                self.recipeCreationStorage.recipeCreation = nil
            }
        )
        let cancel = AlertActionInfo(
            title: L10n.Common.no,
            type: .cancel,
            action: {
                self.recipeCreation = initialRecipe
                self.handleSections(with: nil)
                self.recipeCreationStorage.recipeCreation = nil
            }
        )
        self.showAlert(
            L10n.RecipeCreation.StartAlert.title,
            message: L10n.RecipeCreation.StartAlert.message,
            actions: [confirm, cancel]
        )
    }

    private func handleSections(with recipe: RecipeCreation?) {
        let remoteConfigManager = RemoteConfigManager.shared
        var sections = [Section]()
        var rows = [RecipeCreationViewController.Section.Row]()
        rows.append(.name)

        if let image = recipe?.imageURL, !image.isEmpty {
            rows.append(.image)
        } else {
            rows.append(.imagePlaceholder)
        }

        rows.append(contentsOf: [.description, .composition])

        if remoteConfigManager.remoteConfig.isPaidRecipeEnabled {
            rows.append(.paidRecipe)
        }

        rows.append(contentsOf: [.instruction, .servings, .cookTime, .whenToCook])

        sections = [.init(section: .info, rows: rows)]
        self.sections = sections
        self.mainView.reloadData()
    }

    private func assignTagValues(recipeCreation: RecipeCreation) {
        if let whenToCook = recipeCreation.whenToCook, !whenToCook.isEmpty {
            for cook in whenToCook {
                guard let cookTime = SuggestedDayTimeType(rawValue: cook) else { return }
                selectedCookingTime.append(cookTime)
            }
        }

        if let dishType = recipeCreation.dishType, !dishType.isEmpty {
            for type in dishType {
                guard let dish = SuggestedDishType(rawValue: type) else { return }
                selectedDishTypes.append(dish)
            }
        }

        if let lifestyleType = recipeCreation.lifestyleType, !lifestyleType.isEmpty {
            for type in lifestyleType {
                guard let lifeStyle = SuggestedLifestyleType(rawValue: type) else { return }
                selectedLifestyleTypes.append(lifeStyle)
            }
        }

        if let eventType = recipeCreation.occasion, !eventType.isEmpty {
            for type in eventType {
                guard let event = SuggestedEventType(rawValue: type) else { return }
                selectedEventTypes.append(event)
            }
        }
    }
    
    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        if let _ = recipeCreation?.recipeName,
           let _ = recipeCreation?.ingredients,
           let _ = recipeCreation?.instructions,
           let _ = recipeCreation?.servings,
           let _ = recipeCreation?.cookTime,
           let _ = recipeCreation?.whenToCook {
            guard let instructions = recipeCreation?.instructions else { return }
            for (index, item) in instructions.enumerated() {
                guard let itemIndex = recipeCreation?.instructions.firstIndex(where: { $0.description == item.description }) else { return }
                recipeCreation?.instructions[itemIndex].orderNo = index + 1
            }
            recipeCreation?.isHidden = false
            switch initialState {
            case .edit:
                self.editRecipe(recipe: recipeCreation)
            case .create:
                self.createRecipe(recipe: recipeCreation)
            default:
                break
            }
            saveButtonLoader(isLoading: true)
        } else {
            HapticTouch.generateError()
            show(
                type: .dialog(
                    L10n.RecipeCreation.DialogAlert.title,
                    L10n.RecipeCreation.DialogAlert.message,
                    L10n.RecipeCreation.DialogAlert.okayButton,
                    L10n.RecipeCreation.DialogAlert.fillButton
            ),
                firstAction: nil,
                secondAction: nil
            )
        }
    }
}

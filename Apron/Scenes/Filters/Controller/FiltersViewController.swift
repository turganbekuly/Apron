//
//  FiltersViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import OneSignal

protocol FiltersDisplayLogic: AnyObject {

}

final class FiltersViewController: ViewController {
    // MARK: - Properties
    let interactor: FiltersBusinessLogic
    lazy var sections: [Section] = [
        .init(section: .cookingTime, rows: SuggestedCookingTimeType.allCases.compactMap { .cookingTime($0) }),
        .init(section: .dayTimeType, rows: SuggestedDayTimeType.allCases.compactMap { .dayTimeType($0) }),
//        .init(section: .cuisines, rows: cuisines.compactMap { .cuisine($0) }),
//        .init(section: .addCuisine, rows: [.addCuisine]),
        .init(section: .dishTypes, rows: SuggestedDishType.allCases.compactMap { .dishType($0) }),
//        .init(section: .ingredients, rows: ingredients.compactMap { .ingredient($0) }),
//        .init(section: .addIngredient, rows: [.addIngredient]),
        .init(section: .eventTypes, rows: SuggestedEventType.allCases.compactMap { .eventType($0) })
//        .init(section: .lifestyleTypes, rows: SuggestedLifestyleType.allCases.compactMap { .lifestyleType($0) })
    ]
    var state: State {
        didSet {
            updateState()
        }
    }

    var selectedFilters = SearchFilterRequestBody() {
        didSet {
            mainView.reloadData()
        }
    }

    weak var delegate: ApplyFiltersProtocol?

    var cuisines = [
        RecipeCuisine(id: 1, name: "ASD"),
        RecipeCuisine(id: 2, name: "213"),
        RecipeCuisine(id: 3, name: "vdf"),
        RecipeCuisine(id: 4, name: "sdfasdfasdf"),
        RecipeCuisine(id: 5, name: "AS231234§123D"),
        RecipeCuisine(id: 6, name: "ASdsf asd fasd D"),
        RecipeCuisine(id: 7, name: "dfasd k sdfk")
    ]

    var ingredients: [Product] = []

    var cookingTimePreviousIndex: IndexPath?

    // MARK: - Views

    lazy var mainView: FiltersView = {
        let view = FiltersView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var applyButton: BlackOpButton = {
        let button = BlackOpButton()
        button.backgroundType = .blackBackground
        button.setTitle("Применить", for: .normal)
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var resetFilters: UIBarButtonItem = {
        let item = UIBarButtonItem(
            title: "Сбросить все",
            style: .done,
            target: self,
            action: #selector(clearAllFilters)
        )
        item.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: ApronAssets.gray.color,
                NSAttributedString.Key.font: TypographyFonts.regular14
            ],
            for: .normal
        )

        item.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: ApronAssets.gray.color,
                NSAttributedString.Key.font: TypographyFonts.regular14
            ],
            for: .highlighted
        )

        item.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: ApronAssets.gray.color,
                NSAttributedString.Key.font: TypographyFonts.regular14
            ],
            for: .selected
        )

        return item
    }()

    // MARK: - Init
    init(interactor: FiltersBusinessLogic, state: State) {
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
        navigationItem.title = "Фильтры"
        navigationItem.rightBarButtonItem = resetFilters
    }

    private func configureViews() {
        [
            mainView,
            applyButton
        ].forEach { view.addSubview($0) }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        applyButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        mainView.snp.makeConstraints { make in
            make.bottom.equalTo(applyButton.snp.top).offset(-16)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
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
    private func clearAllFilters() {
        selectedFilters = SearchFilterRequestBody()
    }

    @objc
    private func applyButtonTapped() {
        ApronAnalytics.shared.sendAnalyticsEvent(.filtersApplied(selectedFilters))
        dismiss(animated: true) {
            self.delegate?.filtersApplied(filters: self.selectedFilters)
        }
    }
}

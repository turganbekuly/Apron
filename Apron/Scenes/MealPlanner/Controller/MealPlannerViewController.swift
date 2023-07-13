//
//  MealPlannerViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import Storages
import Extensions
import NVActivityIndicatorView
import OneSignal

protocol MealPlannerDisplayLogic: AnyObject {
    func displayGetMealPlannerRecipes(
        viewModel: MealPlannerDataFlow.GetMealPlannerRecipes.ViewModel
    )
    func displaySaveMealPlannerRecipe(
        viewModel: MealPlannerDataFlow.MealPlannerRecipeOperation.ViewModel
    )
    func displayRemoveMealPlannerRecipe(
        viewModel: MealPlannerDataFlow.MealPlannerRecipeOperation.ViewModel
    )
}

final class MealPlannerViewController: ViewController {
    // MARK: - Properties

    typealias Day = MealPlannerWeekDays
    var startDate = Date()
    var endDate = Date()
    var addingDay: MealPlannerWeekDays?
    var mealPlannerManager = MealPlannerManager.shared

    let interactor: MealPlannerBusinessLogic
    var sections: [Section] = [] {
        didSet {
            mainView.reloadData()
        }
    }

    var mealPlannerRecipes: [MealPlannerResponse] = [] {
        didSet {
            let isMealPlannerEmpty = (mealPlannerRecipes.reduce(0, { $0 + ($1.recipes?.count ?? 0) }) == 0)
            configurePlannerCells(mealPlanner: mealPlannerRecipes)
            addToCartButton.isEnabled = !isMealPlannerEmpty
            guard !isMealPlannerEmpty else {
                OneSignal.sendTag("meal_planner", value: "no_items")
                OneSignal.addTrigger("meal_planner", withValue: "no_items")
                return
            }
            OneSignal.sendTag("meal_planner", value: "has_items")
            OneSignal.addTrigger("meal_planner", withValue: "has_items")
        }
    }

    var state: State {
        didSet {
            updateState()
        }
    }

    // MARK: - Views
    var weekdayCalendarView: WeeklyCalendarView = {
        let view = WeeklyCalendarView()
        return view
    }()

    lazy var mainView: MealPlannerView = {
        let view = MealPlannerView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .circleStrokeSpin,
        color: APRAssets.mainAppColor.color,
        padding: nil
    )

    lazy var addToCartButton: BlackOpButton = {
        let button = BlackOpButton()
        button.setTitle(L10n.Recipe.Ingredients.addToCart, for: .normal)
        button.backgroundType = .blackBackground
        button.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        return button
    }()

    // MARK: - Init
    init(interactor: MealPlannerBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
        configureViews()
        weekdayCalendarView.delegate = self
        ApronAnalytics.shared.sendAnalyticsEvent(.mealPlannerPageViewed)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        OneSignal.addTrigger("meal_planner", withValue: "has_viewed")
        configureNavigation()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    private func configureNavigation() {
        let avatarView = AvatarView()
        avatarView.onTap = { [weak self] in
            guard let self = self else { return }
            self.handleAuthorizationStatus {
                let viewController = ProfileBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
        }

        let cartView = CartButtonView()
        cartView.onTap = { [weak self] in
            let viewController = ShoppingListBuilder(state: .initial(.regular)).build()

            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(viewController, animated: false)
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartView)
        navigationController?.navigationBar.barTintColor = APRAssets.secondary.color
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func configureViews() {
        [mainView, weekdayCalendarView, activityIndicator, addToCartButton].forEach { view.addSubview($0) }

        addToCartButton.isEnabled = false
        activityIndicator.isHidden = true
        activityIndicator.alpha = 0.0

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        weekdayCalendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }

        mainView.snp.makeConstraints {
            $0.top.equalTo(weekdayCalendarView.snp.bottom).offset(16)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(36)
        }

        addToCartButton.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    private func configureColors() {

    }

    private func animationHanlding() {
        
    }

    // MARK: - User actions

    @objc
    private func addToCartButtonTapped() {
        show(type: .loader)
        let cartItems: [CartItem] = mealPlannerRecipes
            .compactMap { $0.recipes }
            .flatMap { $0 }
            .compactMap { $0.ingredients }
            .flatMap { $0 }
            .map {
                CartItem(
                    productId: $0.product?.id ?? 0,
                    productName: $0.product?.name ?? "",
                    productCategoryName: $0.product?.productCategoryName ?? "",
                    productImage: $0.product?.image,
                    amount: $0.amount ?? 0,
                    measurement: $0.measurement ?? "",
                    recipeName: [""],
                    bought: false
                )
            }

        updateCart(cartItems: cartItems) {
            hideLoader()
        }
    }

    // MARK: - Methods

    private func updateCart(cartItems: [CartItem], completion: () -> Void) {
        let cartManager = CartManager.shared
        cartItems.forEach {
            cartManager.update(
                productId: $0.productId,
                productName: $0.productName,
                productCategoryName: $0.productCategoryName,
                productImage: $0.productImage,
                amount: $0.amount,
                measurement: $0.measurement,
                recipeName: $0.recipeName?.first ?? "",
                bought: false
            )
        }

        cartItems.forEach {
            ApronAnalytics.shared.sendAnalyticsEvent(
                .ingredientAdded(
                    IngredientAddedModel(
                        id: $0.productId,
                        name: $0.productName,
                        sourceType: .recipePage
                    )
                )
            )
        }
        completion()
    }

    func dateConverter(date: Date?) -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date ?? Date())
        let month = calendar.component(.month, from: date ?? Date())
        let day = calendar.component(.day, from: date ?? Date())
        return String(format: "%04d-%02d-%02d", year, month, day)
    }

    func isLoadingButton(_ isLoading: Bool) {
        guard isLoading else {
            activityIndicator.isHidden = true
            activityIndicator.alpha = 0.0
            activityIndicator.stopAnimating()
            return
        }

        activityIndicator.isHidden = false
        activityIndicator.alpha = 1.0
        activityIndicator.startAnimating()
    }

    private func configurePlannerCells(mealPlanner: [MealPlannerResponse]) {
        let monday = mealPlanner.first(where: { $0.day == .monday })
        let tuesday = mealPlanner.first(where: { $0.day == .tuesday })
        let wednesday = mealPlanner.first(where: { $0.day == .wednesday })
        let thursday = mealPlanner.first(where: { $0.day == .thursday })
        let friday = mealPlanner.first(where: { $0.day == .friday })
        let saturday = mealPlanner.first(where: { $0.day == .saturday })
        let sunday = mealPlanner.first(where: { $0.day == .sunday })

        sections = [
            .init(section: .monday(.monday), rows: [.monday(monday)]),
            .init(section: .tuesday(.tuesday), rows: [.tuesday(tuesday)]),
            .init(section: .wednesday(.wednesday), rows: [.wednesday(wednesday)]),
            .init(section: .thursday(.thursday), rows: [.thursday(thursday)]),
            .init(section: .friday(.friday), rows: [.friday(friday)]),
            .init(section: .saturday(.saturday), rows: [.saturday(saturday)]),
            .init(section: .sunday(.sunday), rows: [.sunday(sunday)]),
        ]
    }

    // MARK: - Deinit

    deinit {
        NSLog("deinit \(self)")
    }
}

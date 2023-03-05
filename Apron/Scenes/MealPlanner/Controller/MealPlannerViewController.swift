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
            configurePlannerCells(mealPlanner: mealPlannerRecipes)
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
        color: ApronAssets.mainAppColor.color,
        padding: nil
    )

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
        navigationController?.navigationBar.barTintColor = ApronAssets.secondary.color
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func configureViews() {
        [mainView, weekdayCalendarView, activityIndicator].forEach { view.addSubview($0) }

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
    }

    private func configureColors() {

    }

    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - Methods

    func dateConverter(date: Date?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date ?? Date())
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
//        guard let addingDay = addingDay else { return }
//        var dynamicSection: Section.Section = .monday(addingDay)
//        switch addingDay {
//        case .sunday:
//            dynamicSection = .sunday(addingDay)
//        case .monday:
//            dynamicSection = .monday(addingDay)
//        case .tuesday:
//            dynamicSection = .tuesday(addingDay)
//        case .wednesday:
//            dynamicSection = .wednesday(addingDay)
//        case .thursday:
//            dynamicSection = .thursday(addingDay)
//        case .friday:
//            dynamicSection = .friday(addingDay)
//        case .saturday:
//            dynamicSection = .saturday(addingDay)
//        }
//        guard let section = sections.firstIndex(where: { $0.section == dynamicSection}),
//              let view = mainView.headerView(forSection: section) as? MealPlannerHeaderView else {
//            return
//        }
//        if isLoading {
//            view.addButton.startAnimating()
//            return
//        }
//        view.addButton.stopAnimating()
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
}

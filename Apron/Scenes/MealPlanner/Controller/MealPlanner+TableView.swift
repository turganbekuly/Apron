//
//  MealPlanner+TableView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import Foundation
import UIKit
import Models

extension MealPlannerViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row: MealPlannerViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case .monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday:
            let cell: MealPlannerCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        case .onboarding:
            let cell: MealPlannerOnboardingCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension MealPlannerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: MealPlannerViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .monday(planner),
            let .tuesday(planner),
            let .wednesday(planner),
            let .thursday(planner),
            let .friday(planner),
            let .saturday(planner),
            let .sunday(planner):
            guard
                let plannerRecipes = planner,
                let recipes = plannerRecipes.recipes
            else {
                return 220
            }
            return recipes.isEmpty ? 0 : 220
        case .onboarding:
            return 136
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row: MealPlannerViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .monday(planner),
            let .tuesday(planner),
            let .wednesday(planner),
            let .thursday(planner),
            let .friday(planner),
            let .saturday(planner),
            let .sunday(planner):
            guard
                let plannerRecipes = planner,
                let recipes = plannerRecipes.recipes
            else {
                return 220
            }
            return recipes.isEmpty ? 0 : 220
        case .onboarding:
            return 136
        }
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row: MealPlannerViewController.Section.Row = sections[indexPath.section].rows[indexPath.row]
        switch row {
        case let .monday(planner),
            let .tuesday(planner),
            let .wednesday(planner),
            let .thursday(planner),
            let .friday(planner),
            let .saturday(planner),
            let .sunday(planner):
            guard let cell = cell as? MealPlannerCell else { return }
            cell.delegate = self
            cell.configure(mealPlanner: planner)
        case .onboarding:
            guard let cell = cell as? MealPlannerOnboardingCell else { return }
            cell.delegate = self
        }
    }

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let section = sections[section].section
        switch section {
        case .monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday:
            let view: MealPlannerHeaderView = tableView.dequeueReusableHeaderFooterView()
            return view
        default:
            return UIView()
        }
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday:
            return 40
        default:
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = sections[section].section
        switch section {
        case .monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday:
            return 40
        default:
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let section = sections[section].section
        switch section {
        case let .monday(weekDay),
            let .tuesday(weekDay),
            let .wednesday(weekDay),
            let .thursday(weekDay),
            let .friday(weekDay),
            let .saturday(weekDay),
            let .sunday(weekDay):
            guard let view = view as? MealPlannerHeaderView else { return }
            view.delegate = self
            view.configure(with: weekDay)
        default:
            break
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isMealPlannerEmpty else { return }
        
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            addToCartButton.isHidden = true
        } else {
            addToCartButton.isHidden = false
        }

        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height && !isMealPlannerEmpty {
            addToCartButton.isHidden = false
        }
    }
}


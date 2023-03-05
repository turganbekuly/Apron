//
//  MealPlannerView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import UIKit
import APRUIKit

public final class MealPlannerView: UITableView {

    // MARK: - Init

    public init() {
        super.init(frame: .zero, style: .grouped)

        configure()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods

    private func configure() {
        allowsMultipleSelection = false
        backgroundColor = .clear
        separatorStyle = .none

        tableHeaderView = UIView(frame: .init(origin: .zero, size: CGSize(width: 0, height: 0)))
        [
            MealPlannerHeaderView.self
        ].forEach {
            register(aClass: $0)
        }
        [
            MealPlannerCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}


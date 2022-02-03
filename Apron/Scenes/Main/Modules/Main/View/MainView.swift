//
//  MainView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import DesignSystem

public final class MainView: UITableView {

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

        tableHeaderView = UIView(frame: .init(origin: .zero, size: CGSize(width: 0, height: 18)))
        [CommunityCellHeaderView.self].forEach {
            register(aClass: $0)
        }

        [
         MyCommunityCell.self,
         FeaturedCommunityCell.self,
         QuickCommunityCell.self,
         HealthyCommunityCell.self,
         HomemadeCommunityCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}

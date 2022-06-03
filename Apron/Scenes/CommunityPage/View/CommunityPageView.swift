//
//  CommunityPageView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

public final class CommunityPageView: UITableView {

    // MARK: - Initialization

    public init() {
        super.init(frame: .zero, style: .grouped)

        configure()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods

    private func configure() {
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        tableFooterView = UIView(frame: .init(origin: .zero, size: CGSize(width: 0, height: 64)))

        [
            CommunityInfoHeaderView.self
        ].forEach {
            register(aClass: $0)
        }

        [
            CommunityRecipeCell.self,
            EmptyCartCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}

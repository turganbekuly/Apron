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
        super.init(frame: .zero, style: .plain)

        configure()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods

    private func configure() {
        separatorStyle = .none
        tableFooterView = UIView(frame: .init(origin: .zero, size: CGSize(width: 0, height: 64)))

        [
            CommunityInfoCell.self,
            CommunityFilterCell.self,
            CommunitySegmentCell.self,
            CommunityRecipeCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}

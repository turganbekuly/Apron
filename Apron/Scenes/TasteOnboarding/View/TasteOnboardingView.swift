//
//  TasteOnboardingView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

public final class TasteOnboardingView: UITableView {

    // MARK: - Initialization
    public init() {
        super.init(frame: .zero, style: .plain)

        configure()
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    private func configure() {
        separatorStyle = .none
        [TasteOnboardingHeaderCell.self].forEach {
            register(aClass: $0)
        }
        [TasteOnboardingCell.self].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}

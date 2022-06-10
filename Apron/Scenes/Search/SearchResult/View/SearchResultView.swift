//
//  SearchResultView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14.01.2022.
//

import APRUIKit
import UIKit

public final class SearchResultView: UITableView {

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
        allowsMultipleSelection = false
        backgroundColor = .clear
        separatorStyle = .none

        [SearchResultNotFoundCell.self].forEach {
            register(cellClass: $0)
        }
    }

}


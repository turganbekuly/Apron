//
//  ShoppingListView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

final class ShoppingListView: UITableView {
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero, style: .plain)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configure() {
        separatorStyle = .none
        allowsMultipleSelection = true
        [
            EmptyListTableCell.self,
            ShoppingItemCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }
    
    private func configureColors() {
        backgroundColor = .clear
    }

}

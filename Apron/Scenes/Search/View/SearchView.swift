//
//  SearchView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

final class SearchView: UITableView {
    
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
        [SearchHeaderView.self].forEach {
            register(aClass: $0)
        }

        [UITableViewCell.self].forEach {
            register(cellClass: $0)
        }
        
        configureColors()
    }
    
    private func configureColors() {
        backgroundColor = .clear
    }

}

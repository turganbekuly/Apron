//
//  ProfileView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

final class ProfileView: UITableView {
    
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
        tableFooterView = UIView(frame: .init(origin: .zero, size: CGSize(width: .zero, height: 64)))

        [].forEach {
            register(aClass: $0)
        }

        [SettingsAppCell.self].forEach {
            register(cellClass: $0)
        }

        configureColors()
    }
    
    private func configureColors() {
        backgroundColor = .clear
    }

}

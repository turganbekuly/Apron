//
//  TabBarView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

public final class TabBarView: UITableView {
    
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
        
        configureColors()
    }
    
    private func configureColors() {
        backgroundColor = .clear
    }

}

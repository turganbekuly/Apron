//
//  AddCommentView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

final class AddCommentView: UITableView {
    
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
        keyboardDismissMode = .onDrag
        [
            EmojiCell.self,
            TagsCell.self,
            RecipeCreationImageCell.self,
            RecipeCreationPlaceholderImageCell.self,
            RecipeCreationDescriptionCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }
    
    private func configureColors() {
        backgroundColor = .clear
    }

}

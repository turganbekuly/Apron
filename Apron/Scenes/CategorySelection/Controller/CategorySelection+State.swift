//
//  CategorySelection+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension CategorySelectionViewController {
    
    // MARK: - State
    public enum State {
        case initial(CategorySelectionProtocol)
        case displayCategories(model: [CommunityCategory])
        case displayCategoriesFailed(error: AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(delegate):
            self.delegate = delegate
            showLoader()
            getCategories()
        case let .displayCategories(model):
            hideLoader()
            self.categories = model
        case .displayCategoriesFailed:
            break
        }
    }
    
}

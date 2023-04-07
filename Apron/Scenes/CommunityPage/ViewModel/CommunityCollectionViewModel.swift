//
//  CommunityCollectionViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import Models
import Storages
import APRUIKit

protocol ICommunityCollectionViewModel {
    var recipesDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)? { get }
}

struct CommunityCollectionViewModel: ICommunityCollectionViewModel {
    // MARK: - Properties

    weak var recipesDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?

    // MARK: - Init

    init(recipesDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?) {
        self.recipesDelegate = recipesDelegate
    }
}

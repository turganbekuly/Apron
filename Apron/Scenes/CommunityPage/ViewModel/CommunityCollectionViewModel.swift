//
//  CommunityCollectionViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import Models
import Storages
import DesignSystem

protocol ICommunityCollectionViewModel {
    var recipesDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)? { get }
}

struct CommunityCollectionViewModel: ICommunityCollectionViewModel {
    // MARK: - Properties

    var recipesDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?

    // MARK: - Init

    init(recipesDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?) {
        self.recipesDelegate = recipesDelegate
    }
}

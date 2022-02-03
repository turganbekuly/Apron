//
//  CollectionDelegateCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Models
import Storages
import DesignSystem

protocol ICollectionDelegateCellViewModel {
    var collectionDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)? { get }
}

struct CollectionDelegateCellViewModel: ICollectionDelegateCellViewModel {
    // MARK: - Properties

    var collectionDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?

    // MARK: - Init

    init(collectionDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?) {
        self.collectionDelegate = collectionDelegate
    }
}

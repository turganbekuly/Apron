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
    var sectionHeaderTitle: String { get }
    var collectionDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)? { get }
}

struct CollectionDelegateCellViewModel: ICollectionDelegateCellViewModel {
    // MARK: - Properties

    var sectionHeaderTitle: String
    var collectionDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?

    // MARK: - Init

    init(
        sectionHeaderTitle: String,
        collectionDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?) {
            self.sectionHeaderTitle = sectionHeaderTitle
        self.collectionDelegate = collectionDelegate
    }
}

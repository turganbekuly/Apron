//
//  CollectionDelegateCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Models
import Storages
import DesignSystem

protocol IMyCollectionDelegateCellViewModel {
    var sectionHeaderTitle: String { get }
    var showAllButtonEnabled: Bool { get }
    var collectionDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)? { get }
}

struct MyCollectionDelegateCellViewModel: IMyCollectionDelegateCellViewModel {
    // MARK: - Properties

    var sectionHeaderTitle: String
    var showAllButtonEnabled: Bool
    var collectionDelegate: (UICollectionViewDataSource & UICollectionViewDelegateFlowLayout)?
}

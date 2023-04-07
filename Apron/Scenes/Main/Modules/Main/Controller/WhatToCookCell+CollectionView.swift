//
//  WhatToCookCell+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.10.2022.
//

import UIKit

extension WhatToCookCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoriesSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesSection[section].rows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = categoriesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .category:
            let cell: WhatToCookCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension WhatToCookCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = categoriesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .category(category):
            delegate?.navigateToCategoryRecipes(with: category)
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = categoriesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .category:
            let categoryCellWidth: CGFloat = (UIScreen.main.bounds.width - 48.0) / 3.0
            let categoryCellHeight: CGFloat = (UIScreen.main.bounds.width * 168.0) / 375.0
            let categoryCellSize = CGSize(width: categoryCellWidth, height: categoryCellHeight)
            return categoryCellSize
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = categoriesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .category(category):
            guard let cell = cell as? WhatToCookCollectionCell else { return }
            cell.configure(with: category)
        }
    }
}

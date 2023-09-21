//
//  SBITableCell+CollectionView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 10.09.2023.
//

import UIKit
import APRUIKit

extension SBIMainTableCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return productsSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsSection[section].rows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = productsSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .product:
            let cell: SBIMainCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .seeAll:
            let cell: SBIMainSeeAllCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension SBIMainTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = productsSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .product, .seeAll:
            delegate?.sbiProductSelected()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = productsSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .product(product):
            var productName = ""
            if let name = product.name {
                productName = name
            } else {
                productName = L10n.SearchByIngredients.Product.seeMore
            }
            let space: CGFloat = product.image != nil ? 50 : 26
            let width = min(Typography.semibold11(text: productName).styled.size().width + space, collectionView.bounds.width)
            return CGSize(width: width, height: 32)
        case .seeAll:
            let width = min(Typography.semibold11(text: "Еще").styled.size().width + 26, collectionView.bounds.width)
            return CGSize(width: width, height: 32)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = productsSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .product(product):
            guard let cell = cell as? SBIMainCollectionCell else { return }
            cell.configure(with: product)
        case .seeAll:
            guard let cell = cell as? SBIMainSeeAllCollectionCell else { return }
            cell.configure()
        }
    }
}




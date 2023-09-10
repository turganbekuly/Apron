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
        }
    }
}

extension SBIMainTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = productsSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .product:
            delegate?.sbiProductSelected()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = productsSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .product(product):
            let width = min(Typography.semibold10(text: product.name ?? "").styled.size().width + 48, collectionView.bounds.width)
            return CGSize(width: width, height: 32)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = productsSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .product(product):
            guard let cell = cell as? SBIMainCollectionCell else { return }
            cell.configure(with: product)
        }
    }
}




//
//  AdBannerCell+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07.03.2023.
//

import UIKit
import APRUIKit

extension AdBannerCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return bannersSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannersSection[section].rows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = bannersSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .banner:
            let cell: AdBannerCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension AdBannerCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = bannersSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .banner(banner):
            delegate?.adBannerTapped(with: banner)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = bannersSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .banner:
            return CGSize(
                width: UIScreen.main.bounds.width,
                height: Constants.baseBannerHeight * multiplier
            )
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = bannersSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .banner(banner):
            guard let cell = cell as? AdBannerCollectionCell else { return }
            cell.configure(with: banner)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let width = scrollView.frame.width
        pageControl.progress = CGFloat(offset / width)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isAutomatic {
            cancelTimer()
            isAutomatic = false
        }
    }
}

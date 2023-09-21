//
//  CommunityCell+CollectionView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 13.08.2023.
//

import UIKit
import APRUIKit

extension CommunityCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return communitiesSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return communitiesSection[section].rows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = communitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .community:
            let cell: CommunityCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension CommunityCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = communitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .community(community):
            ApronAnalytics.shared.sendAnalyticsEvent(.communityTapped(community.name ?? ""))
            delegate?.navigateToCommunity(with: community.id)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = communitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .community:
            return CGSize(
                width: (UIScreen.main.bounds.width / 2) + 24,
                height: ((UIScreen.main.bounds.width / 2) + 24) * 1.2
            )
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = communitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .community(community):
            guard let cell = cell as? CommunityCollectionViewCell else { return }
            cell.configure(community: community)
        }
    }
}



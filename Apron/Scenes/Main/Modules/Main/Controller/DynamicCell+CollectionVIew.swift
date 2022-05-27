//
//  DynamicCell+CollectionVIew.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.05.2022.
//

import UIKit

extension DynamicCommunityCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dynamicCommunitiesSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dynamicCommunitiesSection[section].rows.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = dynamicCommunitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .community:
            let cell: MainCommunityCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .loader:
            let cell: MainCommunityEmptyCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
}

extension DynamicCommunityCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = dynamicCommunitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .community(community):
            delegate?.navigateToCommunity(with: community.id)
        default:
            break
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let row = dynamicCommunitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .community, .loader:
            return CGSize(width: 200, height: 250)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = dynamicCommunitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .community(community):
            guard let cell = cell as? MainCommunityCollectionCell else { return }
            cell.delegate = cellActionsDelegate
            cell.configure(
                with: CommunityCollectionCellViewModel(community: community)
            )
        default:
            break
        }
    }
}

//
//  MyCommunity+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26.05.2022.
//

import Foundation
import UIKit

extension MyCommunityCell: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return myCommunitiesSection.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCommunitiesSection[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = myCommunitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .myCommunity:
            let cell: MyCommunityCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        case .emptyView:
            let cell: MyCommunityEmptyCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }


}

extension MyCommunityCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = myCommunitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .myCommunity(community):
//            let vc = CommunityPageBuilder(state: .initial(community.id)).build()
//            DispatchQueue.main.async {
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            print("navigate to about")
        case .emptyView:
            print("navigate to about")
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = myCommunitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .myCommunity:
            return CGSize(width: 120, height: 150)
        case .emptyView:
            return CGSize(width: collectionView.bounds.width - 32, height: 57)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = myCommunitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .myCommunity(community):
            guard let cell = cell as? MyCommunityCollectionCell else { return }
            cell.configure(
                with: MyCommunityCollectionViewModel(community: community)
            )
        default:
            break
        }
    }
}


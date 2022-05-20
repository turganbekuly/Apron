//
//  Main+CollectionView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return myCommunitySection.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCommunitySection[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = myCommunitySection[indexPath.section].rows[indexPath.row]
        switch row {
        case .myCommunity:
            let cell: MyCommunityCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }


}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = myCommunitySection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .myCommunity(community):
            let vc = CommunityPageBuilder(state: .initial(community.id)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = myCommunitySection[indexPath.section].rows[indexPath.row]
        switch row {
        case .myCommunity:
            return CGSize(width: 120, height: 150)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row = myCommunitySection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .myCommunity(community):
            guard let cell = cell as? MyCommunityCollectionCell else { return }
            cell.configure(
                with: MyCommunityCollectionViewModel(community: community)
            )
        }
    }
}

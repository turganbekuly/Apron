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
        return communitiesSection.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return communitiesSection[section].rows.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row: MainViewController.CommunitySection.Row = communitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        default:
            let cell: MainCommunityCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
    }


}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = communitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case .community(_):
            let vc = CommunityPageBuilder(state: .initial).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row: MainViewController.CommunitySection.Row = communitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        default:
            return CGSize(width: 200, height: 250)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let row: MainViewController.CommunitySection.Row = communitiesSection[indexPath.section].rows[indexPath.row]
        switch row {
        case let .community(community):
            guard let cell = cell as? MainCommunityCollectionCell else { return }
            cell.delegate = self
            cell.configure(with: community)
        }
    }
}

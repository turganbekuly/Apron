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
        switch collectionView {
        case is MyCommunityCollectionView:
            return myCommunitySection.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case is MyCommunityCollectionView:
            return myCommunitySection[section].rows.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case is MyCommunityCollectionView:
            let row = myCommunitySection[indexPath.section].rows[indexPath.row]
            switch row {
            case .myCommunity:
                let cell: MyCommunityCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
                return cell
            }
        default:
            return UICollectionViewCell()
        }
    }


}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case is MyCommunityCollectionView:
            let row = myCommunitySection[indexPath.section].rows[indexPath.row]
            switch row {
            case .myCommunity:
                let vc = CommunityPageBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        default:
            break
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case is MyCommunityCollectionView:
            let row = myCommunitySection[indexPath.section].rows[indexPath.row]
            switch row {
            case .myCommunity:
                return CGSize(width: 120, height: 150)
            }
        default:
            return CGSize.zero
        }
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case is MyCommunityCollectionView:
            let row = myCommunitySection[indexPath.section].rows[indexPath.row]
            switch row {
            case let .myCommunity(community):
                guard let cell = cell as? MyCommunityCollectionCell else { return }
                cell.configure(
                    with: MyCommunityCollectionViewModel(community: community)
                )
            }
        default:
            break
        }
    }
}

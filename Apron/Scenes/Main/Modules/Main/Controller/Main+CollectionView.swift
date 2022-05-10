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
            return myCommunitySections.count
        case is FeaturedCommunityCollectionView:
            return featuredCommunitySections.count
        case is QuickCommunityCollectionView:
            return quickCommunitySections.count
        case is HealthyCommunityCollectionView:
            return healthCommunitySections.count
        case is HomemadeCommunityCollectionView:
            return homeCommunitySections.count
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case is MyCommunityCollectionView:
            return myCommunitySections[section].rows.count
        case is FeaturedCommunityCollectionView:
            return featuredCommunitySections[section].rows.count
        case is QuickCommunityCollectionView:
            return quickCommunitySections[section].rows.count
        case is HealthyCommunityCollectionView:
            return healthCommunitySections[section].rows.count
        case is HomemadeCommunityCollectionView:
            return homeCommunitySections[section].rows.count
        default:
            return 0
        }
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
        let row = myCommunitySections[indexPath.section].rows[indexPath.row]
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
        switch collectionView {
        case is MyCommunityCollectionView:
            let row: MainViewController.CommunitySection.Row = myCommunitySections[indexPath.section].rows[indexPath.row]
            switch row {
            case let .community(community):
                guard let cell = cell as? MainCommunityCollectionCell else { return }
                cell.delegate = self
                cell.configure(with: community)
            }
        case is FeaturedCommunityCollectionView:
            let row: MainViewController.CommunitySection.Row = featuredCommunitySections[indexPath.section].rows[indexPath.row]
            switch row {
            case let .community(community):
                guard let cell = cell as? MainCommunityCollectionCell else { return }
                cell.configure(with: community)
            }
        case is QuickCommunityCollectionView:
            let row: MainViewController.CommunitySection.Row = quickCommunitySections[indexPath.section].rows[indexPath.row]
            switch row {
            case let .community(community):
                guard let cell = cell as? MainCommunityCollectionCell else { return }
                cell.configure(with: community)
            }
        case is HealthyCommunityCollectionView:
            let row: MainViewController.CommunitySection.Row = healthCommunitySections[indexPath.section].rows[indexPath.row]
            switch row {
            case let .community(community):
                guard let cell = cell as? MainCommunityCollectionCell else { return }
                cell.configure(with: community)
            }
        case is HomemadeCommunityCollectionView:
            let row: MainViewController.CommunitySection.Row = homeCommunitySections[indexPath.section].rows[indexPath.row]
            switch row {
            case let .community(community):
                guard let cell = cell as? MainCommunityCollectionCell else { return }
                cell.configure(with: community)
            }
        default: break
        }
    }
}

//
//  Main+Buttons.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import UIKit

extension MainViewController: IMyCommunityCell {
    public func myCommunity(_ cell: UITableViewCell, didTapJoinButton button: UIButton) {
        // send joined event
    }
}

extension MainViewController: DynamicCommunityCellProtocol {
    func dynamicCommunity(_ cell: UITableViewCell, didTapJoinButton button: UIButton) {
        //
    }
}


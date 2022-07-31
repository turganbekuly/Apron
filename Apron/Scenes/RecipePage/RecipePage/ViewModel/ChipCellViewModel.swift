//
//  ChipCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.07.2022.
//

import Foundation
import APRUIKit

protocol ChipCellViewModelProtocol {
    var backgroundColor: UIColor? { get }
    var title: NSAttributedString? { get }
}

struct ChipCellViewModel: ChipCellViewModelProtocol {

    // MARK: - Properties

    private let chip: String

    var backgroundColor: UIColor? {
        return ApronAssets.lightGray2.color
    }

    var title: NSAttributedString? {
        return Typography.regular14(
            text: chip,
            color: .black,
            textAlignment: .center
        ).styled
    }

    // MARK: - Init

    init(chip: String) {
        self.chip = chip
    }

}


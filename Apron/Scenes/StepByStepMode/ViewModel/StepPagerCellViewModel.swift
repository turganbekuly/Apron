//
//  StepPagerCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 02.09.2022.
//

import APRUIKit
import UIKit

protocol StepPagerCellViewModelProtocol {
    var title: NSAttributedString? { get }
    var image: UIImage? { get }
}

struct StepPagerCellViewModel: StepPagerCellViewModelProtocol {
    // MARK: - Properties

    enum StepPagerType {
        case regular(title: String)
        case image(image: UIImage)
    }

    // MARK: - Init

    var name: String?

    var title: NSAttributedString? {
        Typography.semibold14(
            text: name?.uppercased() ?? "",
            color: .white,
            textAlignment: .center
        ).styled
    }

    var image: UIImage?

    // MARK: - Init

    init(pagerType: StepPagerType) {
        switch pagerType {
        case .regular(let title):
            self.name = title
        case .image(let image):
            self.image = image
        }
    }
}

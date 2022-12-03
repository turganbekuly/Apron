//
//  WhatToCookCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.10.2022.
//

import Models
import Storages
import APRUIKit

protocol WhatToCookCellViewModelProtocol {
    var sectionHeaderTitle: String { get }
    var categories: [WhatToCookCategoryTypes] { get }
}

struct WhatToCookCellViewModel: WhatToCookCellViewModelProtocol {
    // MARK: - Properties

    var sectionHeaderTitle: String
    var categories: [WhatToCookCategoryTypes]
}

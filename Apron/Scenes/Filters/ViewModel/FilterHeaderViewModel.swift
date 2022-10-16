//
//  FilterHeaderViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.10.2022.
//

import Models
import APRUIKit
import UIKit

struct FilterHeaderViewModel {
    var text: String

    var title: NSAttributedString? {
        Typography.semibold16(text: text.uppercased(), color: .black).styled
    }

    // MARK: - Init

    public init(text: String) {
        self.text = text
    }

}

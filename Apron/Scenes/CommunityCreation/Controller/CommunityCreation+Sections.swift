//
//  CommunityCreation+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.05.2022.
//

import Foundation
import Models

extension CommunityCreationViewController {
    struct Section {
        enum Section {
            case info
        }
        enum Row {
            case name
            case image
            case imagePlaceholder
            case description
            case category
            case privacy
            case permission
            case socialMedia
        }
        var section: Section
        var rows: [Row]
    }
}

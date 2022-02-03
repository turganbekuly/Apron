//
//  CommunityFilyerCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

import Foundation

protocol ICommunityFilterCellViewModel: AnyObject {
    var searchbarPlaceholder: String { get }
}

final class CommunityFilterCellViewModel: ICommunityFilterCellViewModel {
    var searchbarPlaceholder: String

    init(searchbarPlaceholder: String) {
        self.searchbarPlaceholder = searchbarPlaceholder
    }
}

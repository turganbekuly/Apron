//
//  RoundedTopViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 08.10.2022.
//

import Foundation

protocol RoundedTopViewModelProtocol {
    var image: String? { get }
    var label: String? { get }
}

struct RoundedTopViewModel: RoundedTopViewModelProtocol {
    var image: String?
    var label: String?
    
    init(
        image: String?,
        label: String?
    ) {
        self.image = image
        self.label = label
    }
}

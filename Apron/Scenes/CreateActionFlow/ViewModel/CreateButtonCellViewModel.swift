//
//  CreateButtonCellViewModel.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.05.2022.
//

import Foundation
import UIKit

protocol CreateButtonCellViewModelProtocol {
    var image: UIImage { get }
    var title: String { get }
    var subtitle: String? { get }
}

struct CreateButtonCellViewModel: CreateButtonCellViewModelProtocol {
    var image: UIImage

    var title: String

    var subtitle: String?
}

//
//  AddComment+TextViewDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.08.2022.
//

import UIKit

extension AddCommentViewController: DescriptionCellDelegate {
    func cell(_ cell: RecipeCreationDescriptionCell, didEnteredDesc descr: String?) {
        addCommentRequestBody?.comment = descr
    }
}

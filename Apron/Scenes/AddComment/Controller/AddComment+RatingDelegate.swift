//
//  AddComment+RatingDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.08.2022.
//

import Foundation

extension AddCommentViewController: RatedProtocol {
    func didRate(with state: EmojiState) {
        selectedRate = state
    }
}

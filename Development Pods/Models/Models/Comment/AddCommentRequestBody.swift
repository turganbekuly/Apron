//
//  AddCommentRequestBody.swift
//  Models
//
//  Created by Akarys Turganbekuly on 10.08.2022.
//

import Foundation

// "recipeId": 1,
// "comment": "asdfadsfa"
// **"tags": [String]**
// **"image": String**

public struct AddCommentRequestBody: Codable {
    private enum CodingKeys: String, CodingKey {
        case recipeId
        case comment
        case tags
        case image
    }

    // MARK: - Properties

    public var recipeId: Int?
    public var comment: String?
    public var tags: [String]?
    public var image: String?

    // MARK: - Init

    public init() { }

    public init?(from comment: RecipeCommentResponse) {
        self.recipeId = comment.id
        self.comment = comment.description
        self.tags = comment.tags
        self.image = comment.image
    }

    // MARK: - Methods

    public func toJSON() -> JSON {
        var params = JSON()
        if let recipeId = recipeId {
            params[CodingKeys.recipeId.rawValue] = recipeId
        }
        if let comment = comment {
            params[CodingKeys.comment.rawValue] = comment
        }
        if let tags = tags {
            params[CodingKeys.tags.rawValue] = tags
        }
        if let image = image {
            params[CodingKeys.image.rawValue] = image
        }
        return params
    }
}

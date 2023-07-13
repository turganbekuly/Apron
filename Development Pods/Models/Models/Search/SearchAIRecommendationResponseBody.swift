//
//  SearchAIRecommendationResponseBody.swift
//  Models
//
//  Created by Акарыс Турганбекулы on 27.05.2023.
//

import Foundation

public struct SearchAIRecommendationResponseBody: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case choices
    }
    
    //MARK: - Properties
    
    var choices: [AIMessageResponse]
    
    //MARK: - Init
    
    public init?(json: JSON) {
        self.choices = (json[CodingKeys.choices.rawValue] as? [JSON])?.compactMap { AIMessageResponse(json: $0) } ?? []
    }
}

public struct AIMessageResponse: Codable {
    private enum CodingKeys: String, CodingKey {
        case message
    }
    
    var message: AIMessage?
    
    //MARK: - Init
    
    public init?(json: JSON) {
        self.message = json[CodingKeys.message.rawValue] as? AIMessage
    }
}

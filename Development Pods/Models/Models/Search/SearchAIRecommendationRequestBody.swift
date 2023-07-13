//
//  SearchAIRecommendationRequestBody.swift
//  Models
//
//  Created by Акарыс Турганбекулы on 27.05.2023.
//

import Foundation

public struct SearchAIRecommendationRequestBody: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case model
        case messages
    }
    
    //MARK: - Properties
    
    var model: String = "gpt-3.5-turbo"
    public var messages: [AIMessage] = []
    
    //MARK: - Init
    
    public init() {}
    
    //MARK: - Methods
    
    public func toJSON() -> JSON {
        var params = JSON()
        params[CodingKeys.model.rawValue] = model
        params[CodingKeys.messages.rawValue] = messages.compactMap { $0.toJSON() }
        return params
    }
}

public struct AIMessage: Codable {
    private enum CodingKeys: String, CodingKey {
       case role, content
    }
    
    //MARK: - Properties
    
    var role: String = ""
    public var content: String = ""
    
    //MARK: - Init
    
    public init(role: String, content: String) {
        self.role = role
        self.content = content
    }
    
    //MARK: - Methods
    
    public func toJSON() -> JSON {
        var params = JSON()
        params[CodingKeys.role.rawValue] = role
        params[CodingKeys.content.rawValue] = content
        return params
    }
}

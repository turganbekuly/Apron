//
//  Extension+Encodable.swift
//  Extensions
//
//  Created by Акарыс Турганбекулы on 26.08.2023.
//

import Foundation

extension Encodable {
    public func toJSON() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            return [:]
        }
        return json
    }
}

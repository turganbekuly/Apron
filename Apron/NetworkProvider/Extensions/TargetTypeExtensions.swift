//
//  TargetTypeExtensions.swift
//  Alamofire
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Moya

extension TargetType {

    // MARK: - Target Name

    var targetName: String {
        let targetString = "\(self)"
        var index: String.Index {
            guard let index = targetString.firstIndex(where: { $0 == "(" }) else {
                return targetString.endIndex
            }

            return index
        }
        return String(targetString[..<index])
    }

}

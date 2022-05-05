//
//  Array+Sequence.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 05.05.2022.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    public func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

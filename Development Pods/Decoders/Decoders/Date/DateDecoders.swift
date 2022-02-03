//
//  DateDecoders.swift
//  Decoders
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import SwiftDate

public enum DateDecoder {

    // MARK: - Methods

    public static func decodeISODate(from string: String?) -> Date? {
        guard let date = string?.toISODate()?.date else { return nil }

        return date
    }

    public static func decodeString(from date: Date?) -> String? {
        guard let date = date else { return nil }

        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = .current
            return formatter
        }()
        return dateFormatter.string(from: date)
    }

}

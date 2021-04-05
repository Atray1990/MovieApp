//
//  DateFormatter.swift
//  PaytmInsiderTest
//
//  Created by shashank atray on 23/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation

extension Date {
    init(dateString:String) {
        self = Date.iso8601Formatter.date(from: dateString)!
    }

    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter
    }()
}

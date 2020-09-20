//
//  HolidayType.swift
//  Holidays
//
//  Created by Thomas Monfre on 9/18/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import Foundation

struct DateTime: Decodable {
    var year: Int
    var month: Int
    var day: Int
}

struct DateInfo: Decodable {
    var iso: String
    var datetime: DateTime
}

struct HolidayState: Codable {
    var id: Int
    var abbrev: String
    var name: String
    var exception: String?
    var iso: String
}

// adopted from: https://stackoverflow.com/questions/52681385/swift-codable-multiple-types
enum HolidayStateValue: Codable {
    case string(String)
    case item([HolidayState])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        // Array<HolidayState>.self adopted from: https://stackoverflow.com/questions/46344963/swift-jsondecode-decoding-arrays-fails-if-single-element-decoding-fails
        if let x = try? container.decode(Array<HolidayState>.self) {
            self = .item(x)
            return
        }
        throw DecodingError.typeMismatch(HolidayStateValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for states"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .item(let x):
            try container.encode(x)
        }
    }
}

struct HolidayType: Decodable {
    var name: String
    var description: String
    var date: DateInfo
    var locations: String
    var type: [String]
    var states: HolidayStateValue
}

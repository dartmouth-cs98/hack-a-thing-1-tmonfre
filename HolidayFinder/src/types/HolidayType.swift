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

struct HolidayType: Decodable {
    var name: String
    var description: String
    var date: DateInfo
}

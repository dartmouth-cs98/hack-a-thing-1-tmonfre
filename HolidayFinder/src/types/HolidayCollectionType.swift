//
//  HolidayCollectionType.swift
//  Holidays
//
//  Created by Thomas Monfre on 9/18/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import Foundation

struct HolidayCollectionType: Decodable {
    var holidays: [HolidayType]
}

struct HolidayResponseType: Decodable {
    var response: HolidayCollectionType
}

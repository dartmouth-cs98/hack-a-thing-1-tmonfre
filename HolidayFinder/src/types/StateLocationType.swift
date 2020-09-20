//
//  StateLocationType.swift
//  HolidayFinder
//
//  Created by Thomas Monfre on 9/20/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import Foundation

struct StateType: Decodable {
    var state: String
    var lat: Double
    var lng: Double
}

struct StateLocationType: Decodable {
    var states: [StateType]
}

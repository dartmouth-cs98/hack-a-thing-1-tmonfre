//
//  StateLocationController.swift
//  HolidayFinder
//
//  Created by Thomas Monfre on 9/20/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import Foundation

struct StateLocationController {
    func getStateLocations () -> [StateType] {
        let stateLocationModel = StateLocationModel()
        
        return stateLocationModel.getStateLocations() ?? []
    }
}

//
//  HolidayDataController.swift
//  Holidays
//
//  Created by Thomas Monfre on 9/18/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import Foundation

struct HolidayDataController {
    func getHolidays (countryCode: String, onHolidayFetch: @escaping(Result<[HolidayType], HolidayRequestError>) -> Void) -> Void {
        let holidayModel = HolidayRequest(countryCode: countryCode)
        
        holidayModel.getHolidays(completion: onHolidayFetch)
    }
}

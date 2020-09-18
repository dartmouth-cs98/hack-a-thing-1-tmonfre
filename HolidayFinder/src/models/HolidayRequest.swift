//
//  HolidayRequest.swift
//  Holidays
//
//  Created by Thomas Monfre on 9/18/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import Foundation

enum HolidayRequestError: Error {
    case UNABLE_TO_FETCH
    case CANNOT_PROCESS_DATA
}

struct HolidayRequest {
    let resourceURL: URL
    let API_KEY = "5bd9305ee32e4a549ca87257ab20c8cdae78d3b7"
    
    init (countryCode:String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays (completion: @escaping(Result<[HolidayType], HolidayRequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.UNABLE_TO_FETCH))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidayResponse = try decoder.decode(HolidayResponseType.self, from: jsonData)
                
                let holidayDetails = holidayResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.CANNOT_PROCESS_DATA))
            }
        }
        
        dataTask.resume()
    }
    
}

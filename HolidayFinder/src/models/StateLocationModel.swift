//
//  StateLocationModel.swift
//  HolidayFinder
//
//  Created by Thomas Monfre on 9/20/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import Foundation

// adopted from: https://programmingwithswift.com/parse-json-from-file-and-url-with-swift/

struct StateLocationModel {
    let FILEPATH = "state-coordinates"
    
    func getStateLocations() -> [StateType]? {
        do {
            if let bundlePath = Bundle.main.path(forResource: FILEPATH, ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    do {
                        let decoder = JSONDecoder()
                        let contents = try decoder.decode(StateLocationType.self, from: jsonData)
                        return contents.states
                    } catch {
                        print(error)
                    }
                }
        } catch {
            print(error)
        }
                
        return nil
    }
}

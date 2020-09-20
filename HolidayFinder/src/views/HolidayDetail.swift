//
//  HolidayDetail.swift
//  HolidayFinder
//
//  Created by Thomas Monfre on 9/18/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import SwiftUI

struct HolidayDetail: View {
    
    var holiday: HolidayType
    var stateLocations: [StateType]
    
    @State private var mapLat: Double = -1
    @State private var mapLng: Double = -1
        
    // generates type text based on number of holiday types in object
    func generateTypeText (holiday: HolidayType) -> String {
        return "Type\(holiday.type.count > 1 ? "s" : "")"
    }
    
    // generates date text in mm/dd/yyyy format
    func generateDateText (holiday: HolidayType) -> String {
        let datetime = holiday.date.datetime
        
        return "\(datetime.month)/\(datetime.day)/\(datetime.year)"
    }
    
    func findStateLocation (holiday: HolidayType) {
        // adopted from: https://stackoverflow.com/questions/24027267/unwrap-an-enum-tuple-outside-of-a-switch-in-swift/31272451
        
        // find lat long on matching state
        if case .item(let items) = holiday.states {
            items.forEach { (holidayState: HolidayState) in
                let matchingState: StateType = self.stateLocations.first(where: { (state: StateType) -> Bool in
                    return state.state == holidayState.abbrev
                })!
                
                self.mapLat = matchingState.lat
                self.mapLng = matchingState.lng
            }
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12.0) {
                Text(holiday.name)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                
                Text(generateDateText(holiday: holiday))
                
                Text(holiday.description)
                
                Text("Locations: \(holiday.locations)")
                
                Text("\(generateTypeText(holiday: holiday)): \(holiday.type.joined(separator: ", "))")
                
                if (self.mapLat > -1 && self.mapLng > -1) {
                    HolidayMapPreview(lat: self.mapLat, lng: self.mapLng)
                        .frame(height: 250)
                }
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .padding(.top, -55)
        .onAppear() {
            if (Locale.current.regionCode! == "US") {
                self.findStateLocation(holiday: self.holiday)
            }
        }
    }
}

struct HolidayDetail_Previews: PreviewProvider {
    
    static var testHoliday = HolidayType(
        name: "name",
        description: "description",
        date: DateInfo(
            iso: "2020-01-01",
            datetime: DateTime(
                year: 2020,
                month: 1,
                day: 1
            )
        ),
        locations: "NH",
        type: ["Observance"],
        states: HolidayStateValue.item([HolidayState(
            id: 29,
            abbrev: "MO",
            name: "Missouri",
            iso: "us-mo"
        )])
    )
    
    static var previews: some View {
        HolidayDetail(holiday: testHoliday, stateLocations: [])
    }
}

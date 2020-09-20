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
        
    // generates type text based on number of holiday types in object
    func generateTypeText (holiday: HolidayType) -> String {
        return "Type\(holiday.type.count > 1 ? "s" : "")"
    }
    
    // generates date text in mm/dd/yyyy format
    func generateDateText (holiday: HolidayType) -> String {
        let datetime = holiday.date.datetime
        
        return "\(datetime.month)/\(datetime.day)/\(datetime.year)"
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
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .padding(.top, -55)
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
        type: ["Observance"]
    )
    
    static var previews: some View {
        HolidayDetail(holiday: testHoliday)
    }
}

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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(holiday.name)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 12)
                
                Text(holiday.description)
                
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
        )
    )
    
    static var previews: some View {
        HolidayDetail(holiday: testHoliday)
    }
}

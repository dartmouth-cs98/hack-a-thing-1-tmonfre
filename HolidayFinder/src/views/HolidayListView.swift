//
//  HolidayListView.swift
//  Holidays
//
//  Created by Thomas Monfre on 9/18/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import SwiftUI

struct HolidayListView: View {
    
    var controller = HolidayDataController()
    
    @State private var countryCode: String = ""
    @State private var holidays: [HolidayType] = []
    
    // when user presses submit, fetch holidays in controller
    func onSubmitPress () -> Void {
        self.controller.getHolidays(
            countryCode: self.countryCode,
            onHolidayFetch: { result in
                switch result {
                    case .success(let holidays):
                        self.setHolidays(holidays: holidays)
                    case .failure(let error):
                        print(error)
                }
            }
        )
    }
    
    // parse through holidays, remove duplicates, and sort
    func setHolidays (holidays: [HolidayType]) -> Void {
        var uniqueHolidays = [HolidayType]()
        
        holidays.forEach({ holiday in
            // only include if not yet included (removes duplicates)
            if (!uniqueHolidays.contains(where: { h in
                return h.name == holiday.name
            })) {
                uniqueHolidays.append(holiday)
            }
        })
        
        // sort and save
        self.holidays = uniqueHolidays
            .sorted(by: { $0.date.iso < $1.date.iso })
    }
    
    // main view
    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading) {
                Text("Holiday Finder")
                    .font(.title)
                Text("Find holidays in a given country by typing the country code below.")
                    .font(.subheadline)
            }
            .padding(.leading)
            .padding(.top)
    
            
            HStack {
                TextField("e.g. US", text: $countryCode)
                    .padding(7)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Button(action: onSubmitPress) {
                    Text("Search")
                        .padding(.leading, 8)
                }
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            .padding(.leading)
            .padding(.trailing)
            
            List {
                ForEach(holidays, id: \.name) { holiday in
                    VStack(alignment: .leading) {
                        Text(holiday.name)
                        Text("\(holiday.date.datetime.month)/\(holiday.date.datetime.day)")
                    }
                }
            }
        }
    }
}

struct HolidayListView_Previews: PreviewProvider {
    static var previews: some View {
        HolidayListView()
    }
}

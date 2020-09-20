//
//  HolidayListView.swift
//  Holidays
//
//  Created by Thomas Monfre on 9/18/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import SwiftUI

struct HolidayList: View {
    
    var controller = HolidayDataController()
    
    @State private var allHolidays: [HolidayType] = []
    @State private var filteredHolidays: [HolidayType] = []
    @State private var isLoading: Bool = false
    @State private var searchTerm: String = ""
    
    // fetches holiday info in the controller
    func fetchHolidays () -> Void {
        self.isLoading = true
        
        self.controller.getHolidays(
            countryCode: Locale.current.regionCode!,
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
        self.isLoading = false

        var uniqueHolidays = [HolidayType]()
        
        holidays.forEach({ holiday in
            // only include if not yet included (removes duplicates)
            if (!uniqueHolidays.contains(where: { h in
                return h.name == holiday.name
            })) {
                uniqueHolidays.append(holiday)
            }
        })
        
        let sortedHolidays = uniqueHolidays
            .sorted(by: { $0.date.iso < $1.date.iso })
        
        self.allHolidays = sortedHolidays
        self.filteredHolidays = sortedHolidays
    }
    
    // filter list of holidays
    func filter () -> Void {
        self.filteredHolidays = self.allHolidays.filter({ (holiday: HolidayType) -> Bool in
            return holiday.name.uppercased().contains(self.searchTerm.uppercased())
        })
    }
    
    // clear user filter and search term
    func clear () -> Void {
        self.filteredHolidays = self.allHolidays
        self.searchTerm = ""
    }
    
    // determine if the search bar should filter or clear
    func shouldFilter () -> Bool {
        return self.allHolidays.count == self.filteredHolidays.count
    }
    
    // main view
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    HStack {
                        TextField("e.g. St. Patrick's Day", text: $searchTerm)
                            .padding(7)
                            .padding(.horizontal, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        Button(action: self.shouldFilter() ? filter : clear) {
                            Text(self.shouldFilter() ? "Search" : "Clear")
                                .padding(.leading, 8)
                        }
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 12)
                }
                
                ZStack {
                    List {
                        ForEach(filteredHolidays, id: \.name) { holiday in
                            NavigationLink(destination: HolidayDetail(holiday: holiday)) {
                                VStack(alignment: .leading) {
                                    Text(holiday.name)
                                    Text("\(holiday.date.datetime.month)/\(holiday.date.datetime.day)")
                                }
                            }
                        }
                    }
                    
                    Spinner(isAnimating: self.isLoading, color: UIColor.black)
                        .padding(.top, -45)
                }
            }
            .navigationBarTitle("Holiday Finder")
        }
        .onAppear() {
            // grab all holiday info
            self.fetchHolidays()
        }
    }
}

struct HolidayListView_Previews: PreviewProvider {
    static var previews: some View {
        HolidayList()
    }
}

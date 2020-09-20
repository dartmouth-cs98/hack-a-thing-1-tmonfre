//
//  HolidayMapPreview.swift
//  HolidayFinder
//
//  Created by Thomas Monfre on 9/20/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import SwiftUI
import MapKit

struct HolidayMapPreview: UIViewRepresentable {
    
    var lat: Double
    var lng: Double
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {        
        let coordinate = CLLocationCoordinate2D(
            latitude: self.lat,
            longitude: self.lng * -1
        )
        
        let span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
}

struct HolidayMapPreview_Previews: PreviewProvider {
    static var previews: some View {
        HolidayMapPreview(lat: 37.1841, lng: 119.4696)
    }
}

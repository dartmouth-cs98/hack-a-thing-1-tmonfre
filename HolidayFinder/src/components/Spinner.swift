//
//  Spinner.swift
//  HolidayFinder
//
//  Created by Thomas Monfre on 9/20/20.
//  Copyright © 2020 Thomas Monfre. All rights reserved.
//

import SwiftUI

// adopted from: https://www.hackingwithswift.com/forums/ios/showing-a-loading-view-within-a-collection-view-section/2151

struct Spinner: UIViewRepresentable {
    let isAnimating: Bool
    let color: UIColor

    func makeUIView(context: UIViewRepresentableContext<Spinner>) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView().style)
        spinner.hidesWhenStopped = true
        spinner.color = color
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Spinner>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner(isAnimating: true, color: UIColor.black)
    }
}

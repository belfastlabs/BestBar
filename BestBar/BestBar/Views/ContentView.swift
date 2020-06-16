//
//  ContentView.swift
//  BestBar
//
//  Created by Chris McLearnon on 16/06/2020.
//  Copyright © 2020 BelfastLabs. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State private var slideOverCardDown = false
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            VStack {
                GeometryReader { geometry in
                    SlideOverCard(
                        isOpen: self.$slideOverCardDown,
                        maxHeight: geometry.size.height * 0.7
                    ) {
                        HStack {
                            SearchBar(text: self.$searchText)
                        }
                    }
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
    }
}

//
//  FlightsRadarView.swift
//  FlightsRadar
//
//  Created by Volodymyr Ilkiv on 15.08.2022.
//

import SwiftUI
import MapKit

// MARK: - FlightsRadarView
struct FlightsRadarView: View {
    
    // MARK: - StateObjects
    @StateObject private var flightsRadarViewModel = FlightsRadarViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50.08815, longitude: 15.41585),
        span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 0))
    
    
    var body: some View {
        VStack() {
            Map(coordinateRegion: $region,
                annotationItems: flightsRadarViewModel.flightsRadars) { item in
                
                MapAnnotation(coordinate: item.coordinate, content: {
                    Image("plain")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .rotationEffect(Angle(degrees: item.rotationAgnle))
                })
            }
            .frame(width: UIScreen.main.bounds.size.width,
                   height: UIScreen.main.bounds.size.width)
    
            List(flightsRadarViewModel.flightsRadars) { dataType in
                HStack {
                    Text(dataType.name)
                    Spacer()
                    VStack {
                        Text("\(dataType.coordinate.latitude)")
                        Text("\(dataType.coordinate.longitude)")
                    }
                }
            }
        }.ignoresSafeArea()
        
    }
}

// MARK: - FlightsRadarView_Previews
struct FlightsRadarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlightsRadarView()
        }
    }
}

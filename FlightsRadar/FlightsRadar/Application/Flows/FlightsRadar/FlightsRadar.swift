//
//  FlightsRadar.swift
//  FlightsRadar
//
//  Created by Volodymyr Ilkiv on 15.08.2022.
//

import Foundation
import CoreLocation

// MARK: - FlightsRadar
struct FlightsRadar: Identifiable {
    let id = UUID()
    
    let name: String
    let longitude: Double
    let latitude: Double
    let rotationAgnle: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

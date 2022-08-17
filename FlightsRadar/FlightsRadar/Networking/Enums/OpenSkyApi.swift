//
//  OpenSkyApi.swift
//  FlightsRadar
//
//  Created by Volodymyr Ilkiv on 15.08.2022.
//

import Foundation
import Combine

// MARK: - OpenSkyApi
enum OpenSkyApi {
    
    // MARK: - Public properties
    static let agent = Agent()
    static let baseUrlString = "https://opensky-network.org/api"
}

// MARK: - OpenSkyApi+Requests
extension OpenSkyApi {
    
    static func getStates(lamin: Double, lomin: Double, lamax: Double, lomax: Double) -> AnyPublisher<FlightState, Error> {
        var urlComponents = URLComponents(string: baseUrlString + "/states/all")
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "lamin", value: "\(lamin)"),
            URLQueryItem(name: "lomin", value: "\(lomin)"),
            URLQueryItem(name: "lamax", value: "\(lamax)"),
            URLQueryItem(name: "lomax", value: "\(lomax)")
        ]
        
        let request = URLRequest(url: (urlComponents?.url)!)
        
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

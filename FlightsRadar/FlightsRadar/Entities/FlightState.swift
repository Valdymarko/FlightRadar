//
//  States.swift
//  FlightsRadar
//
//  Created by Volodymyr Ilkiv on 15.08.2022.
//

import Foundation

// MARK: - FlightState
struct FlightState: Decodable {
    let time: Int
    let states: [[StateVector]]
}

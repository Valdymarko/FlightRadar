//
//  StateVector.swift
//  FlightsRadar
//
//  Created by Volodymyr Ilkiv on 16.08.2022.
//

import Foundation

// MARK: - StateVector
enum StateVector: Codable {

    case bool(Bool)
    case double(Double)
    case string(String)
    case null
    
    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(StateVector.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for State"))
    }
    
    // MARK: - Public methods
    func getString() -> String? {
        switch self {
        case .string(let string):
            return string
        default:
            return nil
        }
    }
    
    func getBool() -> Bool? {
        switch self {
        case .bool(let bool):
            return bool
        default:
            return nil
        }
    }
    
    func getDouble() -> Double? {
        switch self {
        case .double(let double):
            return double
        default:
            return nil
        }
    }
}

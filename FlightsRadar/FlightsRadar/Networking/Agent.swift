//
//  Agent.swift
//  FlightsRadar
//
//  Created by Volodymyr Ilkiv on 15.08.2022.
//

import Foundation
import Combine

// MARK: - Agent
struct Agent {

    // MARK: - Response<T>
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    // MARK: - Public methods
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

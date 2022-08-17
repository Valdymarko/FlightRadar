//
//  FlightsRadarViewModel.swift
//  FlightsRadar
//
//  Created by Volodymyr Ilkiv on 15.08.2022.
//

import Combine
import MapKit

// MARK: - FlightsRadarViewModel
final class FlightsRadarViewModel: ObservableObject {
    
    // MARK: - Published properties
    @Published private(set) var flightsRadars: [FlightsRadar] = []
    
    // MARK: - Private properties
    private var cancellableRequest: AnyCancellable?
    private var timerCancelable: AnyCancellable?

    // MARK: - Constants
    private let lamin = 48.55
    private let lomin = 12.9
    private let lamax = 51.06
    private let lomax = 18.87

    // MARK: - Initalizer
    init() {
        getStates()
        scheduleTimer()
    }
    
    deinit {
        cancellableRequest?.cancel()
        timerCancelable?.cancel()
    }

    // MARK: - Private methods
    private func getStates() {
        cancellableRequest = OpenSkyApi.getStates(lamin: lamin, lomin: lomin, lamax: lamax, lomax: lomax)
            .sink(receiveCompletion: { _ in }) { [weak self] flightState in
                self?.flightsRadars = flightState.states.compactMap({ FlightsRadar(name: $0[1].getString() ?? "",
                                                                                   longitude: $0[5].getDouble() ?? 0.0,
                                                                                   latitude: $0[6].getDouble() ?? 0.0,
                                                                                   rotationAgnle: $0[10].getDouble() ?? 0.0)})
            }
    }
    
    private func scheduleTimer() {
        timerCancelable = Timer
            .publish(every: 10, on: .main, in: .default)
            .autoconnect()
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] output in
                self?.getStates()
            })
    }
}

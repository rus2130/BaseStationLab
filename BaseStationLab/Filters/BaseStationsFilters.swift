//
//  BaseStationsFilters.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

class BaseStationFilters: ObservableObject {
    @Published private var currentProvider: Provider?
    @Published private var currentRegion: String?
    @Published private var currentTechnolody: Technolody?
    
    var currentProviderFilter: String { currentProvider?.rawValue ?? "" }
    var currentRegionFilter: String { currentRegion ?? "" }
    var currentTechnologyFilter: String { (currentTechnolody ?? .lte).filterValue }
    
    public func update(provider: Provider) {
        currentProvider = provider
    }
    
    public func update(region: String) {
        currentRegion = region
    }
    
    public func update(technolody: Technolody) {
        currentTechnolody = technolody
    }
}

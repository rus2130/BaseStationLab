//
//  BaseStationsFilters.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

class BaseStationFilters: ObservableObject {
    @Published var currentProvider: Provider?
    @Published var currentRegion: String?
    @Published var currentTechnolody: Technolody?
    
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

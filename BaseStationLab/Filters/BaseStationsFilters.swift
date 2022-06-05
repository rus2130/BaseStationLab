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
    @Published var currentTechnolody = Technolody.lte
    @Published var currentDetailTecholody = DetailTechology.all
    
    var currentProviderFilter: String { currentProvider?.rawValue ?? "" }
    var currentRegionFilter: String { currentRegion ?? "" }
    var currentTechnologyFilter: String {
        guard currentDetailTecholody != .all else { return currentDetailTecholody.rawValue }
        return currentTechnolody.filterValue
    }
    var currentDetailTecholodyFilter: String { currentDetailTecholody.rawValue }
    
    public func update(provider: Provider) {
        currentProvider = provider
    }
    
    public func update(region: String) {
        currentRegion = region
    }
    
    public func update(technolody: Technolody) {
        currentTechnolody = technolody
    }
    
    public func update(detailTechnolody: DetailTechology) {
        currentDetailTecholody = detailTechnolody
    }
}

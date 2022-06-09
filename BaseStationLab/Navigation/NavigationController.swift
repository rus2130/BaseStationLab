//
//  NavigationController.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import Combine

class NavigationController: ObservableObject {
    static var shared = NavigationController()
    
    @Published var showingRegions = false
    @Published var showingSettlements = false
    @Published var filters = BaseStationFilters()
    @Published var sortState = SortState.name
    
    public func openRegions(provider: Provider) {
        filters.update(provider: provider)
        showingRegions = true
    }
    
    public func openSettlements(region: String) {
        filters.update(region: region)
        showingSettlements = true
    }
}

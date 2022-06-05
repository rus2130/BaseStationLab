//
//  NavigationController.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

class NavigationController: ObservableObject {
    static var shared = NavigationController()
    
    @Published var showingRegions = false
    @Published var showingSettlements = false
    
    public func openRegions() {
        showingRegions = true
    }
    
    public func openSettlements() {
        showingSettlements = true
    }
    
    public func popToRoot() {
        showingSettlements = false
        showingRegions = false 
    }
    
}

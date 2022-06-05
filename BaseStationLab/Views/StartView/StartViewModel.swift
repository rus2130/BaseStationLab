//
//  StartViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

class StartViewModel: ObservableObject {
    @Published var providerModels = [StartViewCellModel]()
    
    private let database = Database()
    
    init() {
        getProviderModels()
    }
    
    public func getProviderModels() {
        database.getBases { [weak self] bases in
            guard let self = self, !bases.isEmpty else { return }
            
            let availableProviders = bases.getAvailableProviders()
            
            availableProviders.forEach { self.createProviderModel($0, bases: bases) }
        }
    }
    
    private func createProviderModel(_ provider: Provider, bases: Results<BaseStation>) {
        guard provider != .invalid else { return }
        
    }
}

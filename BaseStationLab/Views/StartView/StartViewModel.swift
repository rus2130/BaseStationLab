//
//  StartViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

class StartViewModel: ObservableObject {
    @Published var providerModels = [StartCellModel]()
    
    private let database = Database()
    
    init() {
        getProviderModels()
    }
    
    public func getProviderModels() {
        database.getBases { [weak self] bases in
            guard let self = self, !bases.isEmpty else { return }
            
            let availableProviders = bases.getAvailableProviders()
            let preparedProviderModels = availableProviders
                .compactMap { self.createProviderModel($0, bases: bases) }
                .sorted { $0.baseStationsCount > $1.baseStationsCount }
            
            DispatchQueue.main.async {
                self.providerModels = preparedProviderModels
            }
        }
    }
    
    private func createProviderModel(_ provider: Provider, bases: Results<BaseStation>) -> StartCellModel? {
        guard provider != .invalid else { return nil }
        
        let filteredBases = bases.filteredBy(
            provider: provider.rawValue,
            technology: Technolody.lte.filterValue
        )
        
        let cellModel = DataMapper.basesToStartViewCellModel(bases: filteredBases)
        
        return cellModel
    }
}

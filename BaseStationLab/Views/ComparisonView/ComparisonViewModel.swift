//
//  ComparisonViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import Foundation
import RealmSwift

class ComparisonViewModel: ObservableObject {
    @Published var comparisonModels = [ComparisonCellModel]()
    @Published var showingLocalitySelection = false
    @Published var isLoading = false
    
    let database = Database()
    
    init() {
        getComparisonModels()
    }
    
    public func getComparisonModels() {
        isLoading = true
        
        database.getBases { bases in
            let availableProviders = bases.getAvailableProviders()
            
            let preparedComparisonModels = availableProviders
                .compactMap { self.createComparisonModel($0, bases: bases) }
                .sorted { $0.basesCount > $1.basesCount }
            
            DispatchQueue.main.async {
                self.comparisonModels = preparedComparisonModels
                self.isLoading = false
            }
        }
    }
    
    private func createComparisonModel(_ provider: Provider, bases: Results<BaseStation>) -> ComparisonCellModel? {
        guard provider != .invalid else { return nil }
        
        let filteredBases = bases.filteredBy(provider: provider.rawValue)
        
        guard !filteredBases.isEmpty else { return nil }
        
        let cellModel = DataMapper.basesToComparisonCellModel(bases: filteredBases)
        
        return cellModel
    }
    
//    public func createComparisonModel(_ provider: Provider, bases: Result<BaseStation>) -> ComparisonCellModel? {
//        guard provider != .invalid else { return nil }
//    }
    
//    public func getProviderModels() {
//        DispatchQueue.main.async { self.isLoading = true }
//
//        database.getBases { [weak self] bases in
//            guard let self = self, !bases.isEmpty else { return }
//            let filteredBases = bases.filteredBy(technology: self.currentTecholodyFilter)
//
//            let availableProviders = filteredBases.getAvailableProviders()
//            let preparedProviderModels = availableProviders
//                .compactMap { self.createProviderModel($0, bases: bases) }
//                .sorted { $0.baseStationsCount > $1.baseStationsCount }
//
//            DispatchQueue.main.async {
//                self.providerModels = preparedProviderModels
//                self.isLoading = false
//            }
//        }
//    }
//    private func createProviderModel(_ provider: Provider, bases: Results<BaseStation>) -> StartCellModel? {
//        guard provider != .invalid else { return nil }
//
//        let filteredBases = bases.filteredBy(
//            provider: provider.rawValue,
//            technology: currentTecholodyFilter
//        )
//
//        let cellModel = DataMapper.basesToStartViewCellModel(bases: filteredBases)
//
//        return cellModel
//    }
}

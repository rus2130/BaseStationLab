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
}

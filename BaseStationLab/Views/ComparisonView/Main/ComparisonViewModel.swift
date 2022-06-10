//
//  ComparisonViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import Foundation
import RealmSwift
import Combine

class ComparisonViewModel: ObservableObject {
    @Published var comparisonModels = [ComparisonCellModel]()
    @Published var showingLocalitySelection = false
    @Published var isLoading = false
    
    @Published var currentLocalitySearch: SettlementSearchModel?
    
    private var cancellables = Set<AnyCancellable>()
    private let database = Database()
    
    init(currentLocalitySearch: SettlementSearchModel? = nil) {
        self.currentLocalitySearch = currentLocalitySearch
        getComparisonModels()
        setupSearch()
    }
    
    public func getComparisonModels() {
        isLoading = true
        
        database.getBases { bases in
            var filteredBases = bases
            
            if let currentLocalitySearch = self.currentLocalitySearch {
                filteredBases = bases.filteredBy(region: currentLocalitySearch.region, settlement: currentLocalitySearch.settlement)
            }
            
            let availableProviders = filteredBases.getAvailableProviders()
            
            let preparedComparisonModels = availableProviders
                .compactMap { self.createComparisonModel($0, bases: filteredBases) }
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
    
    private func setupSearch() {
        $currentLocalitySearch
            .dropFirst()
            .removeDuplicates()
            .sink { [weak self] search in
                guard let self = self else { return }
                
                self.currentLocalitySearch = search
                self.getComparisonModels()
            }
            .store(in: &cancellables)
    }
}

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
    @Published var currentTechology = Technolody.lte { didSet {
        updateCurrentTechnolody()
    }}
    @Published var currentDetailTechnolody = DetailTechology.all
    @Published var showingFilterSheet = false 
    
    private var currentTecholodyFilter: String {
        guard currentDetailTechnolody != .all else { return currentTechology.filterValue }
        
        return currentDetailTechnolody.rawValue
    }
    
    private let database = Database()
    
    init() {
        getProviderModels()
    }
    
    public func updateDetailTechnolody(technolody: DetailTechology) {
        currentDetailTechnolody = technolody
        getProviderModels()
    }
    
    public func getProviderModels() {
        database.getBases { [weak self] bases in
            guard let self = self, !bases.isEmpty else { return }
            let filteredBases = bases.filteredBy(technology: self.currentTecholodyFilter)
            
            let availableProviders = filteredBases.getAvailableProviders()
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
            technology: currentTecholodyFilter
        )
        
        let cellModel = DataMapper.basesToStartViewCellModel(bases: filteredBases)
        
        return cellModel
    }
    
    private func updateCurrentTechnolody() {
        NavigationController.shared.filters.update(technolody: currentTechology)
        currentDetailTechnolody = .all
        getProviderModels()
    }
}

//
//  SettlementsViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

class SettlementsViewModel: ObservableObject {
    @Published var settlementModels = [SettlementCellModel]()
    
    let database = Database()
    let filters = NavigationController.shared.filters
    
    init() {
        getSettlements()
    }
    
    private func getSettlements() {
        database.getBases { bases in
            let filteredBases = bases.filteredBy(
                provider: self.filters.currentProviderFilter,
                technology: self.filters.currentTechnologyFilter,
                region: self.filters.currentRegionFilter
            )
            
            let availableSettlements = filteredBases.getAvailableSettlements()
            let preparedSettlementsModels = availableSettlements
                .compactMap { self.createSettlementModel($0, bases: bases) }
            
            DispatchQueue.main.async {
                self.settlementModels = preparedSettlementsModels
            }
        }
    }
    
    private func createSettlementModel(_ settlement: String, bases: Results<BaseStation>) -> SettlementCellModel {
        let filteredBases = bases.filteredBy(
            provider: filters.currentProviderFilter,
            technology: filters.currentTechnologyFilter,
            region: filters.currentRegionFilter,
            settlement: settlement
        )
        
        let cellModel = DataMapper.basesToSettlementCellModel(bases: filteredBases)
        
        return cellModel
    }
}

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
    @Published var showingFilterActionSheet = false
    @Published var showingSortSheet = false 
    
    let database = Database()
    let filters = NavigationController.shared.filters
    
    init() {
        getSettlements()
    }
    
    public func updateDetailTechnolody(techolody: DetailTechology) {
        filters.update(detailTechnolody: techolody)
        getSettlements()
    }
    
    public func updateSortState(_ sortState: SortState) {
        NavigationController.shared.sortState = sortState
        
        settlementModels.sort { lhs, rhs in
            switch sortState {
            case .name: return lhs.settlement < rhs.settlement
            case .basesCount: return lhs.baseStationsCount > rhs.baseStationsCount
            case .date: return lhs.lastUpdated > rhs.lastUpdated
            }
        }
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

//
//  RegionsViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

class RegionsViewModel: ObservableObject {
    @Published var regionModels = [RegionCellModel]()
    @Published var showingFilterSheet = false
    @Published var showingSortSheet = false
    
    let database = Database()
    let filters = NavigationController.shared.filters
    let sortState = NavigationController.shared.sortState
    
    init() {
        getRegions()
    }
    
    public func updateDetailTechnolody(techolody: DetailTechology) {
        filters.update(detailTechnolody: techolody)
        getRegions()
    }
    
    public func updateSortState(_ sortState: SortState) {
        NavigationController.shared.sortState = sortState
        
        regionModels.sort { lhs, rhs in
            switch sortState {
            case .name: return lhs.region < rhs.region
            case .basesCount: return lhs.baseStationsCount > rhs.baseStationsCount
            case .date: return lhs.lastUpdated > rhs.lastUpdated
            }
        }
    }
    
    private func getRegions() {
        database.getBases { [weak self] bases in
            guard let self = self, !bases.isEmpty else { return }
            
            let filteredBases = bases.filteredBy(
                provider: self.filters.currentProviderFilter,
                technology: self.filters.currentTechnologyFilter
            )
            
            let availableRegions = filteredBases.getAvailableRegions()
            let preparedRegionModels = availableRegions
                .compactMap { self.createRegionModel($0, bases: bases) }
            
            DispatchQueue.main.async {
                self.regionModels = preparedRegionModels
            }
        }
    }
    
    private func createRegionModel(_ region: String, bases: Results<BaseStation>) -> RegionCellModel {
        let filteredBases = bases.filteredBy(
            provider: filters.currentProviderFilter,
            technology: filters.currentTechnologyFilter,
            region: region
        )
        
        let cellModel = DataMapper.basesToRegionCellModel(bases: filteredBases)
        
        return cellModel
    }
}

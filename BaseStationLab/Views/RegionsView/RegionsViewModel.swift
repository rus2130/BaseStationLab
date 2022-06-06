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
    @Published var isLoading = true
    
    let database = Database()
    let filters = NavigationController.shared.filters
    let sortState = NavigationController.shared.sortState
    
    init() {
        getRegions()
    }
    
    public func updateDetailTechnolody(techolody: DetailTechology) {
        getRegions()
    }
    
    public func updateSortState(_ sortState: SortState) {
        regionModels.sort(sortState: sortState)
    }
    
    public func getNavigationTitle() -> String {
        guard filters.currentDetailTecholody != .all else { return filters.currentTechnolody.rawValue }
        return filters.currentDetailTecholody.title
    }
    
    private func getRegions() {
        DispatchQueue.main.async { self.isLoading = true }
        database.getBases { [weak self] bases in
            guard let self = self, !bases.isEmpty else { return }
            
            let filteredBases = bases.filteredBy(
                provider: self.filters.currentProviderFilter,
                technology: self.filters.currentTechnologyFilter
            )
            
            let availableRegions = filteredBases.getAvailableRegions()
            
            availableRegions
                .enumerated()
                .forEach {
                    self.createRegionModel(
                        $0.element,
                        index: $0.offset,
                        totalCount: availableRegions.count,
                        bases: bases
                    )
                }
        }
    }
    
    private func createRegionModel(_ region: String, index: Int, totalCount: Int, bases: Results<BaseStation>) {
        let filteredBases = bases.filteredBy(
            provider: filters.currentProviderFilter,
            technology: filters.currentTechnologyFilter,
            region: region
        )
        
        let cellModel = DataMapper.basesToRegionCellModel(bases: filteredBases)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let index = self.regionModels.firstIndex(where: { $0.region == cellModel.region }) {
                self.regionModels[index] = cellModel
            } else {
                self.regionModels.append(cellModel)
            }
            if index == totalCount - 1 {
                self.regionModels.sort(sortState: self.sortState)
                self.isLoading = false
            }
        }
    }
}

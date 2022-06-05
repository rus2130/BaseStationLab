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
    
    let database = Database()
    
    init() {
        getRegions()
    }
    
    private func getRegions() {
        database.getBases { [weak self] bases in
            guard let self = self, !bases.isEmpty else { return }
            let filteredBases = bases.filteredBy(provider: Provider.kyivstar.rawValue, technology: Technolody.lte.filterValue)
            let availableRegions = filteredBases.getAvailableRegions()
            let preparedRegionModels = availableRegions
                .compactMap { self.createRegionModel($0, bases: bases) }
                .sorted { $0.baseStationsCount > $1.baseStationsCount }
            
            DispatchQueue.main.async {
                self.regionModels = preparedRegionModels
            }
        }
    }
    
    private func createRegionModel(_ region: String, bases: Results<BaseStation>) -> RegionCellModel {
        let filteredBases = bases.filteredBy(
            provider: Provider.kyivstar.rawValue,
            technology: Technolody.lte.filterValue,
            region: region
        )
        
        let cellModel = DataMapper.basesToRegionCellModel(bases: filteredBases)
        
        return cellModel
    }
}

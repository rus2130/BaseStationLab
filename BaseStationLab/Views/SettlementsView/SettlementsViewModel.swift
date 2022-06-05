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
    
    init() {
        getSettlements()
    }
    
    private func getSettlements() {
        database.getBases { bases in
            let filteredBases = bases.filteredBy(provider: Provider.kyivstar.rawValue, technology: Technolody.lte.filterValue, region: "Волинська")
            
            let availableSettlements = filteredBases.getAvailableSettlements()
            let preparedSettlementsModels = availableSettlements
                .compactMap { self.createSettlementModel($0, region: "Волинська", bases: bases) }
                .sorted { $0.baseStationsCount > $1.baseStationsCount }
            
            DispatchQueue.main.async {
                print(preparedSettlementsModels.count)
                self.settlementModels = preparedSettlementsModels
            }
        }
    }
    
    private func createSettlementModel(_ settlement: String, region: String, bases: Results<BaseStation>) -> SettlementCellModel {
        let filteredBases = bases.filteredBy(
            provider: Provider.kyivstar.rawValue,
            technology: Technolody.lte.filterValue,
            region: region,
            settlement: settlement
        )
        
        let cellModel = DataMapper.basesToSettlementCellModel(bases: filteredBases)
        
        return cellModel
    }
}

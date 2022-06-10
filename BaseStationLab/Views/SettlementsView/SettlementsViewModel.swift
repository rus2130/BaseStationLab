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
    
    @Published var showingComparison = false
    @Published var currentSearchModel: ComparisonSearchModel?
    
    let database = Database()
    let filters = NavigationController.shared.filters
    let sortState = NavigationController.shared.sortState
    
    init() {
        getSettlements()
    }
    
    public func updateDetailTechnolody(techolody: DetailTechnolody) {
        getSettlements()
    }
    
    public func updateSortState(_ sortState: SortState) {
        settlementModels.sort(sortState: sortState)
    }
    
    public func getNavigationTitle() -> String {
        let region = settlementModels.first?.region ?? ""
        guard filters.currentDetailTecholody != .all else {
            return region + " " + filters.currentTechnolody.rawValue
        }
        return region + " " + filters.currentDetailTecholody.title
    }
    
    public func openComparison(model: SettlementCellModel) {
        currentSearchModel = .init(region: model.region, settlement: model.settlement)
        showingComparison = true
    }
    
    private func getSettlements() {
        database.getBases { bases in
            let filteredBases = bases.filteredBy(
                provider: self.filters.currentProviderFilter,
                technology: self.filters.currentTechnologyFilter,
                region: self.filters.currentRegionFilter
            )
            
            let availableSettlements = filteredBases.getAvailableSettlements()
            
            availableSettlements
                .enumerated()
                .forEach { index, element in
                    self.createSettlementModel(
                        element,
                        index: index,
                        totalCount: availableSettlements.count,
                        bases: bases
                    )
                }
        }
    }
    
    private func createSettlementModel(_ settlement: String, index: Int, totalCount: Int, bases: Results<BaseStation>) {
        let filteredBases = bases.filteredBy(
            provider: filters.currentProviderFilter,
            technology: filters.currentTechnologyFilter,
            region: filters.currentRegionFilter,
            settlement: settlement
        )
        
        let cellModel = DataMapper.basesToSettlementCellModel(bases: filteredBases)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let index = self.settlementModels.firstIndex(where: { $0.settlement == cellModel.settlement }) {
                self.settlementModels[index] = cellModel
            } else {
                self.settlementModels.append(cellModel)
            }
            if index == totalCount - 1 {
                self.settlementModels.sort(sortState: self.sortState)
            }
        }
    }
}

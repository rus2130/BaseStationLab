//
//  ComparisonSettlementSelectionViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import Foundation
import Combine

class ComparisonSearchModel: Identifiable, Equatable {
    static func == (lhs: ComparisonSearchModel, rhs: ComparisonSearchModel) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String { settlement + region }
    
    var region: String
    var settlement: String
    
    var regionToShow: String
    
    init(region: String, settlement: String) {
        if region != "Київ" {
            self.regionToShow = region + " обл."
        } else {
            self.regionToShow = region
        }
        self.region = region
        self.settlement = settlement
    }
}

class ComparisonSettlementSelectionViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredSettlementSearchModels = [ComparisonSearchModel]()
    
    private var settlementSearchModels = [ComparisonSearchModel]()
    private var cancellables = Set<AnyCancellable>()
    
    private let database = Database()
    
    init() {
        getSearchElemets()
        setupText()
    }
    
    private func getSearchElemets() {
        database.getBases { bases in
            self.settlementSearchModels = bases
                .getAvailableRegionsAndSettlements()
                .map { ComparisonSearchModel(region: $0.region, settlement: $0.settlement) }
            DispatchQueue.main.async {
                self.filteredSettlementSearchModels = Array(self.settlementSearchModels.prefix(1500))
            }
        }
    }
    
    private func setupText() {
        $searchText
            .dropFirst()
            .debounce(for: 0.4, scheduler: RunLoop.current)
            .sink { [weak self] text in
                guard let self = self, !text.isEmpty else {
                    self?.filteredSettlementSearchModels = Array((self?.settlementSearchModels ?? []).prefix(1500))
                    return
                }
                self.filteredSettlementSearchModels = self.settlementSearchModels
                    .filter { model in
                        model.settlement.contains(text) ||
                        model.region.contains(text)
                    }
                    .sorted { DataMapper.locationSorted(lhs: $0.settlement, rhs: $1.settlement) }
            }
            .store(in: &cancellables)
    }
}


//
//  BaseStationCell+Sort+Extension.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 06.06.2022.
//

import Foundation

extension Array where Element == RegionCellModel {
    mutating func sort(sortState: SortState) {
        self.sort { lhs, rhs in
            switch sortState {
            case .name: return lhs.region < rhs.region
            case .basesCount: return lhs.baseStationsCount > rhs.baseStationsCount
            case .date: return lhs.lastUpdated > rhs.lastUpdated
            }
        }
    }
    
    func sorted(sortState: SortState) -> [RegionCellModel] {
        self.sorted { lhs, rhs in
            switch sortState {
            case .name: return lhs.region < rhs.region
            case .basesCount: return lhs.baseStationsCount > rhs.baseStationsCount
            case .date: return lhs.lastUpdated > rhs.lastUpdated
            }
        }
    }
}

extension Array where Element == SettlementCellModel {
    mutating func sort(sortState: SortState) {
        self.sort { lhs, rhs in
            switch sortState {
            case .name: return lhs.settlement < rhs.settlement
            case .basesCount: return lhs.baseStationsCount > rhs.baseStationsCount
            case .date: return lhs.lastUpdated > rhs.lastUpdated
            }
        }
    }
    
    func sorted(sortState: SortState) -> [SettlementCellModel] {
        self.sorted { lhs, rhs in
            switch sortState {
            case .name: return lhs.settlement < rhs.settlement
            case .basesCount: return lhs.baseStationsCount > rhs.baseStationsCount
            case .date: return lhs.lastUpdated > rhs.lastUpdated
            }
        }
    }
}

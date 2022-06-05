//
//  DataMapper.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

class DataMapper {
    static func getRruName(from: String) -> String {
        if let usableName = StringConstants.bsNames[from] {
            return usableName
        } else {
            return "Інші"
        }
    }
    
    static func getProviderName(from: String) -> String {
        var returnValue = ""
        let values = from.components(separatedBy: ",")
        
        returnValue = StringConstants.freqOps[values[0]] ?? StringConstants.freqOps[values[0].components(separatedBy: "-")[0]] ?? StringConstants.freqOps[values[0].components(separatedBy: ".")[0]] ?? "Invalid"
        if returnValue == "Invalid" {
            returnValue = StringConstants.freqOps[from] ?? StringConstants.freqOps[from.components(separatedBy: "-")[0]] ?? StringConstants.freqOps[from.components(separatedBy: ".")[0]] ?? "Invalid"
        }
        return returnValue
    }
    
    static func basesToStartViewCellModel(bases: Results<BaseStation>) -> StartCellModel {
        let provider = bases.getProvider()
        let regionsCount = bases.getRegionsCount()
        let settlementsCount = bases.getSettlementsCount()
        let basesCount = bases.count
        let lastUpdated = bases.getLastUpdated()
        let groupedRru = bases.getGroupedRru()
        
        return StartCellModel(
            provider: provider,
            regionsCount: regionsCount,
            settlementsCount: settlementsCount,
            baseStationsCount: basesCount,
            lastUpdated: lastUpdated,
            rruNames: groupedRru
        )
    }
    
    static func basesToRegionCellModel(bases: Results<BaseStation>) -> RegionCellModel {
        let provider = bases.getProvider()
        let region = bases.getRegion()
        let settlementsCount = bases.getSettlementsCount()
        let basesCount = bases.count
        let lastUpdated = bases.getLastUpdated()
        let groupedRru = bases.getGroupedRru()
        
        return RegionCellModel(
            provider: provider,
            region: region,
            settlementsCount: settlementsCount,
            baseStationsCount: basesCount,
            lastUpdated: lastUpdated,
            rruNames: groupedRru
        )
    }
    
    static func basesToSettlementCellModel(bases: Results<BaseStation>) -> SettlementCellModel {
        let provider = bases.getProvider()
        let region = bases.getRegion()
        let settlement = bases.getSettlement()
        let basesCount = bases.count
        let lastUpdated = bases.getLastUpdated()
        let groupedRru = bases.getGroupedRru()
        
        return SettlementCellModel(
            provider: provider,
            region: region,
            settlement: settlement,
            baseStationsCount: basesCount,
            lastUpdated: lastUpdated,
            rruNames: groupedRru
        )
    }
}

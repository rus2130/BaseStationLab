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
    
    static func basesToComparisonCellModel(bases: Results<BaseStation>) -> ComparisonCellModel {
        let provider = bases.getProvider()
        
        let lteBases = bases.filteredBy(technology: Technolody.lte.filterValue)
        let umtsBases = bases.filteredBy(technology: Technolody.umts.filterValue)
        let gsmBases = bases.filteredBy(technology: Technolody.gsm.filterValue)
        
        let lteBasesCount = lteBases.count
        let umtsBasesCount = umtsBases.count
        let gsmBasesCount = gsmBases.count
        
        let basesCount = lteBasesCount + umtsBasesCount + gsmBasesCount
        
        let lteTechologiesCount = lteBases.getTechnologiesCount()
        let umtsTechologiesCount = umtsBases.getTechnologiesCount()
        let gsmTechologiesCount = gsmBases.getTechnologiesCount()
        
        return ComparisonCellModel(
            provider: provider,
            basesCount: basesCount,
            lteBasesCount: lteBasesCount,
            lteTechnologiesCount: lteTechologiesCount,
            umtsBasesCount: umtsBasesCount,
            umtsTechnologiesCount: umtsTechologiesCount,
            gsmBasesCount: gsmBasesCount,
            gsmTechnologiesCount: gsmTechologiesCount
        )
    }
    
    static func locationSorted(lhs: String, rhs: String) -> Bool {
        return lhs.compare(rhs, options: [.diacriticInsensitive, .caseInsensitive]) == .orderedAscending
    }
}

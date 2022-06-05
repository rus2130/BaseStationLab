//
//  SettlementCellModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

struct SettlementCellModel: Equatable, Identifiable, Hashable {
    var id: String {
        provider.rawValue + settlement + String(region)
    }
    
    var provider: Provider
    var region: String
    var settlement: String
    var baseStationsCount: Int
    var lastUpdated: Date
    var rruNames: [String]
    
    var providerString: String { provider.rawValue }
    var baseStationsCountString:String  { String(baseStationsCount) }
    var lastUpdatedString: String { lastUpdated.toString() }
    var rruNamesString: String { rruNames.joined(separator: "  ") }
}

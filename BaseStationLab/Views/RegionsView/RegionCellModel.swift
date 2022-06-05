//
//  RegionsViewCellModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

struct RegionCellModel: Equatable, Identifiable, Hashable {
    var id: String {
        provider.rawValue + String(regionName)
    }
    
    var provider: Provider
    var region: String
    var settlementsCount: Int
    var baseStationsCount: Int
    var lastUpdated: Date
    var rruNames: [String]
    
    var regionName: String { "\(region) \(region == "Київ" ? "" : "обл.")" }
    var providerString: String { provider.rawValue }
    var settlementsCountString: String {
        "\(settlementsCount) \(settlementsCount > 1 ? "н. пунктів" : "н. пункт")"
    }
    var baseStationsCountString:String  { String(baseStationsCount) }
    var lastUpdatedString: String { lastUpdated.toString() }
    var rruNamesString: String { rruNames.joined(separator: "  ") }
}

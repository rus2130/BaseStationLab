//
//  StartCellModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

struct StartCellModel: Equatable, Identifiable, Hashable {
    var id: String {
        provider.rawValue +
        String(regionsCount) +
        String(settlementsCount) +
        String(baseStationsCount) +
        String(rruNames.joined(separator: ""))
    }
    
    var provider: Provider
    var regionsCount: Int
    var settlementsCount: Int
    var baseStationsCount: Int
    var lastUpdated: Date
    var rruNames: [String]
    
    var providerString: String { provider.rawValue }
    var regionsCountString: String {
        "\(regionsCount) \(regionsCount > 1 ? "регіонів" : "регіон")"
        
    }
    var settlementsCountString: String {
        "\(settlementsCount) \(settlementsCount > 1 ? "н. пунктів" : "н. пункт")"
    }
    var baseStationsCountString:String  { String(baseStationsCount) }
    var lastUpdatedString: String { lastUpdated.toString() }
    var rruNamesString: String { rruNames.joined(separator: "  ") }
}

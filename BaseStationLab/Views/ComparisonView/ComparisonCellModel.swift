//
//  ComparisonCellModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import Foundation

struct ComparisonCellModel {
    var id: String { provider.rawValue }
   
    var provider: Provider
    var basesCount: Int
    var lteBasesCount: Int
    var lteTechnologiesCount: [Int: Int]
    var umtsBasesCount: Int
    var umtsTechnologiesCount: [Int: Int]
    var gsmBasesCount: Int
    var gsmTechnologiesCount: [Int: Int]
    
    
    var baseStationsCount: Int
    var lastUpdated: Date
    var rruNames: [String]
    
    var providerString: String { provider.rawValue }
    
}

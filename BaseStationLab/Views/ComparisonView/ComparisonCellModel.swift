//
//  ComparisonCellModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import Foundation

struct ComparisonCellModel: Equatable, Identifiable, Hashable {
    var id: String { provider.rawValue }
   
    var provider: Provider
    var basesCount: Int
    var lteBasesCount: Int
    var lteTechnologiesCount: [Int: Int]
    var umtsBasesCount: Int
    var umtsTechnologiesCount: [Int: Int]
    var gsmBasesCount: Int
    var gsmTechnologiesCount: [Int: Int]
        
    var providerString: String { provider.rawValue }
    var basesCountString: String { String(basesCount) }
    var lteBasesCountString: String { String(lteBasesCount) }
    var umtsBasesCountString: String { String(umtsBasesCount) }
    var gsmBasesCountString: String { String(gsmBasesCount) }
    
    var sortedLteTechnologies: [(technology: String, count: String)] {
        lteTechnologiesCount
            .sorted(by: { $0.key > $1.key })
            .map { (technology: String($0.key), count: String($0.value)) }
    }
    
    var sortedUmtsTechnologies: [(technology: String, count: String)] {
        umtsTechnologiesCount
            .sorted(by: { $0.key > $1.key })
            .map { (technology: String($0.key), count: String($0.value)) }
    }
    
    var sortedGsmTechnologies: [(technology: String, count: String)] {
        gsmTechnologiesCount
            .sorted(by: { $0.key > $1.key })
            .map { (technology: String($0.key), count: String($0.value)) }
    }
}

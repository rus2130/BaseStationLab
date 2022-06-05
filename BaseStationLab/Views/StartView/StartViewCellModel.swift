//
//  StartViewCellModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

struct StartViewCellModel {
    var provider: Provider
    var regionsCount: Int
    var settlementsCount: Int
    var baseStationsCount: Int
    var lastUpdated: Date
    var rruNames: [String]
}

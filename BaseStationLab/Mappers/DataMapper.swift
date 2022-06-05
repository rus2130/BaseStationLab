//
//  DataMapper.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

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
}

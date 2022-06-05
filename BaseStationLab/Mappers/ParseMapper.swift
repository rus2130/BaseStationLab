//
//  ParseMapper.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

class ParseMapper {
    static func getBaseStationsFrom(data: [[String]]) -> [BaseStation] {
        var prepareStations = [BaseStation]()
        for tableRow in data {
            guard tableRow.count > 9 else { continue }
            let prepareStation = BaseStation()
            prepareStation.id = tableRow[0] + tableRow[9] + tableRow[4]
            prepareStation.usePermit = tableRow[0]
            prepareStation.dateOfIssue = tableRow[1].toDate()
            prepareStation.validUntil = tableRow[2]
            prepareStation.region = tableRow[3]
            prepareStation.settlement = tableRow[4]
            prepareStation.rezType = DataMapper.getRruName(from: tableRow[5])
            prepareStation.radiationClass = tableRow[6]
            prepareStation.freqIn = DataMapper.getProviderName(from: tableRow[7])
            prepareStation.freqOut = tableRow[8]
            prepareStation.radioTechnology = tableRow[9]
            prepareStations.append(prepareStation)
        }
        return prepareStations
    }
}

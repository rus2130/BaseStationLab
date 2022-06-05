//
//  BasesController.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

class BasesController {
    let database = Database()
    
    public func checkBasesStatus() {
        database.getBasesCount { basesCount in
            if basesCount == 0 {
                self.startParse()
            }
        }
    }
    
    private func startParse() {
        Task {
            var bases = [[String]]()
            
            for detailTechonoly in Technolody.all.detailTechologies {
                let parser = BasesParser(detailTechology: detailTechonoly)
                
                bases.append(contentsOf: await parser.startParse())
            }
            
            updateDatabase(data: bases)
        }
    }
    
    private func updateDatabase(data: [[String]]) {
        let bases = ParseMapper.getBaseStationsFrom(data: data)
        database.save(baseStations: bases)
    }
}

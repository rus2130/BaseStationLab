//
//  BasesController.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

class BasesController {
    let database = Database()
    
    public func checkBasesStatus(completion: @escaping () -> ()) {
        database.getBasesCount { basesCount in
            if basesCount == 0 {
                self.startParse(completion: completion)
            } else {
                completion()
            }
        }
    }
    
    private func startParse(completion: @escaping () -> ()) {
        Task.detached(priority: .userInitiated) {
            var bases = [[String]]()
            
            for detailTechonoly in Technolody.all.detailTechologies {
                let parser = BasesParser(detailTechnolody: detailTechonoly)
                
                bases.append(contentsOf: await parser.startParse())
            }
            
            self.updateDatabase(data: bases, completion: completion)
        }
    }
    
    private func updateDatabase(data: [[String]], completion: @escaping () -> ()) {
        let bases = ParseMapper.getBaseStationsFrom(data: data)
        database.save(baseStations: bases, completion: completion)
    }
}

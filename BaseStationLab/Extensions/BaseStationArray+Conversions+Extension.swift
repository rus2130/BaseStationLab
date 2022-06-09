//
//  BaseStation+Extension.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

//MARK: Conversions
extension Results where Element: BaseStation {
    func getLastUpdated() -> Date {
        self
            .sorted(byKeyPath: "dateOfIssue", ascending: false)
            .first?.dateOfIssue ?? Date()
    }
    
    func getGroupedRru() -> [String] {
        let rru = self.value(forKey: "rezType") as? [String] ?? []
        
        return Dictionary(grouping: rru, by: { $0 })
            .sorted(by: { $0.value.count > $1.value.count })
            .map({ "\($0.key): \($0.value.count)" })
    }
    
    func getSettlementsCount() -> Int {
        self.distinct(by: ["region", "settlement"]).count
    }
    
    func getRegionsCount() -> Int {
        self.distinct(by: ["region"]).count
    }
    
    func getProvider() -> Provider {
        Provider(rawValue: self.first?.freqIn ?? "") ?? .invalid
    }
    
    func getRegion() -> String {
        self.first?.region ?? ""
    }
    
    func getSettlement() -> String {
        self.first?.settlement ?? ""
    }
    
    func getAvailableProviders() -> [Provider] {
        let providers = Set(self.value(forKey: "freqIn") as? [String] ?? [])
        return providers.map { Provider(rawValue: $0) ?? .invalid }
    }
    
    func getAvailableRegions() -> [String] {
        Array(Set(self.value(forKey: "region") as? [String] ?? [])).sorted(by: { $0 < $1 })
    }
    
    func getAvailableSettlements() -> [String] {
        Array(Set(self.value(forKey: "settlement") as? [String] ?? [])).sorted(by: { $0 < $1 })
    }
    
    func getTechnologiesCount() -> [Int: Int] {
        let technologies = self.value(forKey: "radioTechnology") as? [String] ?? []
        
        let preparedTechnologies: [Int] = technologies.compactMap { technology in
            if technology == "UMTS" {
                return 2100
            } else {
                return Int(technology.digits)
            }
        }
        
        return Dictionary(grouping: preparedTechnologies) { $0 }.mapValues { $0.count }
    }
}

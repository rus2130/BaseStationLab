//
//  BaseStationArray+Filters+Extension.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

extension Results where Element: BaseStation {
    
    func filteredBy(provider: String? = nil, technology: String? = nil, region: String? = nil, settlement: String? = nil) -> Results<Element> {
        let providerPredicate = NSPredicate(format: "freqIn LIKE %@", "*\(provider ?? "")*")
        let invalidProviderPredicate = NSPredicate(format: "freqIn != %@", "Invalid")
        let technologyPredicate = NSPredicate(format: "radioTechnology LIKE %@", "*\(technology ?? "")*")
        let regionPredicate = NSPredicate(format: "region LIKE %@", "*\(region ?? "")*")
        let settlementPredicate = NSPredicate(format: "settlement LIKE %@", "*\(settlement ?? "")*")
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [providerPredicate, invalidProviderPredicate, technologyPredicate, regionPredicate, settlementPredicate])
        
        return self.filter(compoundPredicate)
    }
}

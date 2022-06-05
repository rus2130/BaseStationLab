//
//  BaseStation.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import RealmSwift

class BaseStation: Object {
    @Persisted var id: String
    @Persisted var usePermit: String
    @Persisted var dateOfIssue: Date
    @Persisted var validUntil: String
    @Persisted var region: String
    @Persisted var settlement: String
    @Persisted var rezType: String
    @Persisted var radiationClass: String
    @Persisted var freqIn: String
    @Persisted var freqOut: String
    @Persisted var radioTechnology: String
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

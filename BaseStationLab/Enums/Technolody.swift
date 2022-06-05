//
//  Technolody.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

enum Technolody: String, CaseIterable {
    case lte, umts, gsm, all
    
    var detailTechologies: [DetailTechology] {
        switch self {
        case .lte:
            return [.lte2600, .lte1800, .lte900]
        case .umts:
            return [.umts]
        case .gsm:
            return [.gsm1800, .gsm900]
        case .all:
            return [.lte2600, .lte1800, .lte900, .umts ,.gsm1800, .gsm900]
        }
    }
}

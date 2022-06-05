//
//  Technolody.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

enum Technolody: String, CaseIterable {
    case lte = "LTE"
    case umts = "UMTS"
    case gsm = "GSM"
    case all = "ALL"
    
    var filterValue: String {
        switch self {
        case .lte: return "LTE"
        case .umts: return "UMTS"
        case .gsm: return "GSM"
        case .all: return ""
        }
    }
    
    var detailTechologies: [DetailTechology] {
        switch self {
        case .lte: return [.lte2600, .lte1800, .lte900]
        case .umts: return [.umts]
        case .gsm: return [.gsm1800, .gsm900]
        case .all: return [.lte2600, .lte1800, .lte900, .umts ,.gsm1800, .gsm900]
        }
    }
}

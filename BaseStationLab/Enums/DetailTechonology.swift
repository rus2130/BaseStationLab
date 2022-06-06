//
//  DetailTechonology.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation

enum DetailTechnolody: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case all = "ALL"
    case lte2600 = "LTE-2600"
    case lte1800 = "LTE-1800"
    case lte900 = "LTE-900"
    case umts = "UMTS"
    case gsm1800 = "GSM-1800"
    case gsm900 = "GSM-900"
    
    var title: String {
        switch self {
        case .all: return "ALL"
        case .lte2600: return "LTE 2600"
        case .lte1800: return "LTE 1800"
        case .lte900: return "LTE 900"
        case .umts: return "UMTS"
        case .gsm1800: return "GSM 1800"
        case .gsm900: return "GSM 900"
        }
    }
}

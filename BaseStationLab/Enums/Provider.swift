//
//  Provider.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import SwiftUI

enum Provider: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case kyivstar = "Kyivstar"
    case vodafone = "Vodafone"
    case lifecell = "Lifecell"
    case invalid = "Invalid"
    
    var backgroundColor: Color {
        switch self {
        case .kyivstar: return Color(red: 34/255, green: 159/255, blue: 255/255)
        case .vodafone: return  Color(red: 230/255, green: 0, blue: 0)
        case .lifecell: return Color(red: 31/255, green: 80/255, blue: 156/255)
        case .invalid: return .white
        }
    }
}

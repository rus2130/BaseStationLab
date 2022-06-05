//
//  Provider.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import Foundation
import SwiftUI

enum Provider: String, CaseIterable {
    case kyivstar = "Kyivstar"
    case vodafone = "Vodafone"
    case lifecell = "Lifecell"
    case invalid = "Invalid"
    
    var backgroundColor: Color {
        switch self {
        case .kyivstar:
            return .blue
        case .vodafone:
            return .red
        case .lifecell:
            return .purple
        case .invalid:
            return .white
        }
    }
}

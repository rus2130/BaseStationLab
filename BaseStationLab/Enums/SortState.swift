//
//  SortState.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 06.06.2022.
//

import Foundation

enum SortState {
    case name, basesCount, date
    
    var title: String {
        switch self {
        case .name: return "За назвою"
        case .basesCount: return "За кількістю БС"
        case .date: return "За датою"
        }
    }
}

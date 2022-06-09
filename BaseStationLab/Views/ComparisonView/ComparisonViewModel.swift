//
//  ComparisonViewModel.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import Foundation

class ComparisonViewModel: ObservableObject {
    @Published var comparisonModels = [ComparisonCellModel]()
    @Published var showingLocalitySelection = false 
    let database = Database()
    
}

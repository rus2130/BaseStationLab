//
//  ComparisonView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import SwiftUI

struct ComparisonView: View {
    var body: some View {
        ScrollView(.vertical) {
            comparisonCells
        }
        .navigationTitle("Порівняння")
    }
    
    private var comparisonCells: some View {
        LazyVStack(spacing: 16) {
            ForEach(0..<3) { _ in
                ComparisonCellView()
            }
        }
        .padding(.horizontal, 24)
    }
}

struct ComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComparisonView()
        }
    }
}

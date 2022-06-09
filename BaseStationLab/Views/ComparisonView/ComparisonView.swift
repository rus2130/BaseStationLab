//
//  ComparisonView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import SwiftUI

struct ComparisonView: View {
    @StateObject var viewModel = ComparisonViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            comparisonCells
        }
        .toolbar {
            localityToolbar
        }
        .navigationTitle("Порівняння")
        .overlay(selectionSheet)
    }
    
    private var comparisonCells: some View {
        LazyVStack(spacing: 16) {
            ForEach(0..<3) { _ in
                ComparisonCellView()
            }
        }
        .padding(.horizontal, 24)
    }
    
    private var localityToolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                viewModel.showingLocalitySelection = true
            } label: {
                HStack {
                    Text("Україна")
                    Image(systemName: "chevron.down")
                }
                .font(.system(size: 16, weight: .semibold))
            }
        }
    }
    
    private var selectionSheet: some View {
        ZStack{}
            .sheet(isPresented: $viewModel.showingLocalitySelection) {
                ComparisonSettlementSelectionView()
            }
    }
}

struct ComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComparisonView()
        }
    }
}

//
//  ComparisonView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import SwiftUI
import Shimmer

struct ComparisonView: View {
    @StateObject var viewModel: ComparisonViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            comparisonCells
        }
        .toolbar {
            localityToolbar
        }
        .navigationTitle("Порівняння")
        .overlay(selectionSheet)
        .animation(.easeIn, value: viewModel.isLoading)
    }
    
    private var comparisonCells: some View {
        ZStack {
            if viewModel.isLoading {
                loadingState
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.comparisonModels) { model in
                        ComparisonCellView(model: model)
                    }
                }
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
                    let currentSearchModel = viewModel.currentSearchModel
                    let title = currentSearchModel == nil ? "Україна" : (currentSearchModel?.settlement ?? "")
                    Text(title)
                    Image(systemName: "chevron.down")
                }
                .font(.system(size: 16, weight: .semibold))
            }
        }
    }
    
    private var selectionSheet: some View {
        ZStack{}
            .sheet(isPresented: $viewModel.showingLocalitySelection) {
                ComparisonSettlementSelectionView(currentSearchModel: $viewModel.currentSearchModel)
            }
    }
    
    private var loadingState: some View {
        LazyVStack(spacing: 16) {
            ForEach(Provider.allCases) { provider in
                ComparisonCellView(
                    model: ComparisonCellModel(
                        provider: provider,
                        basesCount: 10000,
                        lteBasesCount: 10000,
                        lteTechnologiesCount: [1000:1000],
                        umtsBasesCount: 10000,
                        umtsTechnologiesCount: [1000:1000],
                        gsmBasesCount: 10000,
                        gsmTechnologiesCount: [1000:1000]
                    )
                )
                .blur(radius: 8)
                .shimmering()
            }
        }
    }
}

struct ComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComparisonView(viewModel: .init())
        }
    }
}

//
//  RegionsView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI
import Shimmer

struct RegionsView: View {
    @StateObject var navigationController = NavigationController.shared
    @StateObject var viewModel = RegionsViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            regions
            settlementsNavigation
        }
        .animation(.easeIn, value: viewModel.regionModels)
        .toolbar {
            toolbarSort
            toolbarFilter
        }
        .navigationTitle(viewModel.getNavigationTitle())
        .overlay(filterSheet)
        .overlay(sortSheet)
    }
    
    private var regions: some View {
        LazyVStack(spacing: 12) {
            ForEach(viewModel.regionModels) { regionModel in
                Button {
                    navigationController.openSettlements(region: regionModel.region)
                } label: {
                    RegionViewCell(model: regionModel)
                        .disabled(viewModel.isLoading)
                        .blur(radius: viewModel.isLoading ? 8 : 0)
                        .shimmering(active: viewModel.isLoading, duration: 1, bounce: false)
                }
            }
        }
        .padding(24)
    }
    
    private var toolbarSort: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.showingSortSheet = true
            } label: {
                Image(systemName: "arrow.up.arrow.down")
            }
        }
    }
    
    private var toolbarFilter: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.showingFilterSheet = true
            } label: {
                Image("filterIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
        }
    }
    
    private var settlementsNavigation: some View {
        NavigationLink(
            isActive: $navigationController.showingSettlements,
            destination: {
                SettlementsView()
                    .frame(maxWidth: 500)
            },
            label: { EmptyView() }
        )
    }
    
    private var filterSheet: some View {
        ZStack {}
            .overlay(
                FilterActionSheet(
                    isPresented: $viewModel.showingFilterSheet,
                    action: viewModel.updateDetailTechnolody
                )
            )
    }
    
    private var sortSheet: some View {
        ZStack {}
            .overlay(
                SortActionSheet(
                    isPresented: $viewModel.showingSortSheet,
                    action: viewModel.updateSortState
                )
            )
    }
}

struct RegionsView_Previews: PreviewProvider {
    static var previews: some View {
        RegionsView()
    }
}

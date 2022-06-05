//
//  RegionsView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct RegionsView: View {
    @StateObject var navigationController = NavigationController.shared
    @StateObject var viewModel = RegionsViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            regions
            settlementsNavigation
        }
        .animation(.easeIn, value: viewModel.regionModels)
        .toolbar { toolbarSort }
        .overlay(filterSheet)
    }
    
    private var regions: some View {
        LazyVStack(spacing: 12) {
            ForEach(viewModel.regionModels) { regionModel in
                Button {
                    navigationController.openSettlements(region: regionModel.region)
                } label: {
                    RegionViewCell(model: regionModel)
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var toolbarSort: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.showingFilterSheet = true
            } label: {
                Image(systemName: "arrow.up.arrow.down")
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
}

struct RegionsView_Previews: PreviewProvider {
    static var previews: some View {
        RegionsView()
    }
}

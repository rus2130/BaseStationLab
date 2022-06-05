//
//  StartView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct StartView: View {
    @StateObject var navigationController = NavigationController.shared
    @StateObject var viewModel = StartViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 24) {
                filters
                providers
            }
            regionsNavigation
        }
        .navigationTitle(viewModel.getNavigationTitle())
        .toolbar {
            toolbarComparison
            toolbarFilter
        }
        .overlay(filterSheet)
        .animation(.easeIn, value: viewModel.providerModels)
    }
    
    private var providers: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.providerModels) { providerModel in
                Button {
                    navigationController.openRegions(provider: providerModel.provider)
                } label: {
                    StartViewCell(model: providerModel)
                }
            }
        }
        .padding([.horizontal, .bottom], 24)
    }
    
    private var filters: some View {
        Picker("", selection: $viewModel.currentTechology) {
            ForEach(Technolody.allCases) { techology in
                Text(techology.rawValue)
                    .tag(techology)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal, 24)
    }
    
    private var toolbarComparison: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
            } label: {
                Text("Порівняння")
            }
        }
    }
    
    private var regionsNavigation: some View {
        NavigationLink(
            isActive: $navigationController.showingRegions,
            destination: {
                RegionsView()
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
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .previewDevice("iPhone 12")
    }
}

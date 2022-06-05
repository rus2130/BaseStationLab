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
        .navigationTitle("LTE")
        .toolbar { toolbarComparison }
    }
    
    private var providers: some View {
        LazyVStack(spacing: 16) {
            ForEach(viewModel.providerModels) { providerModel in
                Button {
                    navigationController.openRegions()
                } label: {
                    StartViewCell(model: providerModel)
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var filters: some View {
        Picker("", selection: .constant("LTE")) {
            ForEach(["LTE", "UMTS", "EDGE", "ALL"], id: \.self) { techology in
                Text(techology)
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
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .previewDevice("iPhone 12")
    }
}

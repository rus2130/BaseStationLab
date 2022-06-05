//
//  SettlementsView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct SettlementsView: View {
    @StateObject var viewModel = SettlementsViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            settlements
        }
        .toolbar { toolbarSort }
        .overlay(filterSheet)
        .animation(.easeIn, value: viewModel.settlementModels)
    }
    
    private var settlements: some View {
        LazyVStack(spacing: 12) {
            ForEach(viewModel.settlementModels) { settlementModel in
                SettlementsViewCell(model: settlementModel)
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var toolbarSort: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.showingFilterActionSheet = true
            } label: {
                Image(systemName: "arrow.up.arrow.down")
            }
        }
    }
    
    private var filterSheet: some View {
        ZStack {}
            .overlay(
                FilterActionSheet(
                    isPresented: $viewModel.showingFilterActionSheet,
                    action: viewModel.updateDetailTechnolody
                )
            )
    }
}

struct SettlementsView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementsView()
    }
}

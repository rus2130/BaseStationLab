//
//  RegionsView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct RegionsView: View {
    @StateObject var navigationController = NavigationController.shared
    
    var body: some View {
        ScrollView(.vertical) {
            regions
            settlementsNavigation
        }
        .toolbar { toolbarSort }
    }
    
    private var regions: some View {
        LazyVStack(spacing: 12) {
            ForEach(0..<25) { _ in
                Button {
                    navigationController.openSettlements()
                } label: {
                    RegionsViewCell()
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    private var toolbarSort: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                
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
}

struct RegionsView_Previews: PreviewProvider {
    static var previews: some View {
        RegionsView()
    }
}

//
//  ComparisonSettlementSelectionView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import SwiftUI

struct ComparisonSettlementSelectionView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = ComparisonSettlementSelectionViewModel()
    
    @Binding var currentSearchModel: ComparisonSearchModel?
    
    var body: some View {
        List {
            Section {
                locations
            } header: {
                header
            }
        }
        .listStyle(PlainListStyle())
        .ignoresSafeArea(edges: .top)
    }
    
    private var locations: some View {
        ForEach(viewModel.filteredSettlementSearchModels) { searchModel in
            locationCell(searchModel)
        }
    }
    
    private func locationCell(_ model: ComparisonSearchModel) -> some View {
        Button {
            currentSearchModel = model
            dismiss.callAsFunction()
        } label: {
            HStack {
                Text(model.settlement)
                Spacer()
                Text(model.regionToShow)
            }
        }
    }
    
    private var header: some View {
        HStack {
            resetButton
            searchTextfields
            closeButton
        }
    }
    
    private var searchTextfields: some View {
        TextField("Пошук регіону або н.п.", text: $viewModel.searchText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    
    private var resetButton: some View {
        Button {
            currentSearchModel = nil 
            dismiss.callAsFunction()
        } label: {
            Text("Скинути")
        }
    }
    
    private var closeButton: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            Image(systemName: "chevron.down")
                .font(.system(size: 16, weight: .semibold))
        }
    }
}

struct ComparisonSettlementSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ComparisonSettlementSelectionView(currentSearchModel: .constant(nil))
    }
}

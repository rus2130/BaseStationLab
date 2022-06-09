//
//  ComparisonSettlementSelectionView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import SwiftUI

struct ComparisonSettlementSelectionView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        List {
            Section {
                ForEach(0..<3000) { _ in
                    Button {
                        dismiss.callAsFunction()
                    } label: {
                        Text(UUID().uuidString)
                    }
                }
            } header: {
                TextField("", text: .constant("TEST"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .listStyle(PlainListStyle())
        .ignoresSafeArea(edges: .top)
    }
}

struct ComparisonSettlementSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ComparisonSettlementSelectionView()
    }
}

//
//  StartView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 24) {
                filters
                providers
            }
        }
        .navigationTitle("LTE")
        .toolbar {
            toolbarComparison
        }
    }
    
    private var providers: some View {
        LazyVStack(spacing: 16) {
            ForEach(0..<3) { _ in
                StartViewCell()
                    .padding(.horizontal, 24)
            }
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
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .previewDevice("iPhone 12")
    }
}

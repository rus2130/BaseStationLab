//
//  SettlementsView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct SettlementsView: View {
    var body: some View {
        ScrollView(.vertical) {
            settlements
        }
        .toolbar { toolbarSort }
    }
    
    private var settlements: some View {
        LazyVStack(spacing: 12) {
            ForEach(0..<25) { _ in
                SettlementsViewCell()
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
}

struct SettlementsView_Previews: PreviewProvider {
    static var previews: some View {
        SettlementsView()
    }
}

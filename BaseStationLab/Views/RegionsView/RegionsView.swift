//
//  RegionsView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct RegionsView: View {
    var body: some View {
        ScrollView(.vertical) {
            regions
        }
        .toolbar { toolbarSort }
    }
    
    private var regions: some View {
        LazyVStack(spacing: 12) {
            ForEach(0..<25) { _ in
                RegionsViewCell()
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

struct RegionsView_Previews: PreviewProvider {
    static var previews: some View {
        RegionsView()
    }
}

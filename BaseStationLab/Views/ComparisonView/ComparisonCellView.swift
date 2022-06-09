//
//  ComparisonCellView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import SwiftUI

struct ComparisonCellView: View {
    var body: some View {
        card
            .background(Provider.kyivstar.backgroundColor)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 2)
    }
    
    private var card: some View {
        VStack(spacing: 24) {
            HStack(spacing: 24) {
                lteSection
                umtsSection
            }
            gsmSection
        }
        .foregroundColor(.white)
        .font(.system(size: 16, weight: .medium))
        .padding(24)
        .frame(maxWidth: .infinity)
    }
    
    private var providerName: some View {
        Text("Kyivstar")
            .font(.system(size: 20, weight: .bold))
    }
    
    private var basesCount: some View {
        Text("18958")
            .font(.system(size: 20, weight: .bold))
    }
    
    private var lteSection: some View {
        VStack(spacing: 4) {
            technologyBasesCount()
            techologiesBasesCount()
        }
    }
    
    private var umtsSection: some View {
        VStack(spacing: 4) {
            technologyBasesCount()
            techologiesBasesCount()
        }
    }
    
    private var gsmSection: some View {
        VStack(spacing: 4) {
            technologyBasesCount()
            techologiesBasesCount()
        }
    }
    
    private func technologyBasesCount() -> some View {
        Text("LTE: 18959")
            .font(.system(size: 18, weight: .semibold))
    }
    
    private func techologiesBasesCount() -> some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { i in
                Text("\(i): 3202")
            }
        }
    }
}

struct ComparisonCellView_Previews: PreviewProvider {
    static var previews: some View {
        ComparisonCellView()
    }
}

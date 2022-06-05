//
//  StartViewCell.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct StartViewCell: View {
    var body: some View {
        card
            .background(Color.blue)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 2)
    }
    
    private var card: some View {
        VStack(spacing: 20) {
            HStack {
                coverageSection
                Spacer(minLength: 0)
                updatedSection
            }
            hardware
        }
        .foregroundColor(.white)
        .font(.system(size: 16, weight: .medium))
        .padding(24)
    }
    
    private var coverageSection: some View {
        VStack(spacing: 20) {
            providerName
            VStack(spacing: 0) {
                coverageTitle
                regions
                settlements
            }
        }
    }
    
    private var updatedSection: some View {
        VStack(spacing: 20) {
            basesCount
            VStack(spacing: 0) {
                updatedTitle
                lastUpdated
            }
        }
    }
    
    private var providerName: some View {
        Text("Kyivstar")
            .font(.system(size: 20, weight: .bold))
    }
    
    private var basesCount: some View {
        Text("18958")
            .font(.system(size: 20, weight: .bold))
    }
    
    private var coverageTitle: some View {
        Text("Покриття:")
    }
    
    private var regions: some View {
        Text("25 регіонів")
    }
    
    private var settlements: some View {
        Text("25 н.пункти")
    }
    
    private var updatedTitle: some View {
        Text("Оновлено:")
    }
    
    private var lastUpdated: some View {
        Text("01.01.2022")
    }
    
    private var hardware: some View {
        Text("Huawei: 4566  Erricson: 4416  Інші: 1188")
            .multilineTextAlignment(.center)
    }
}

struct StartViewCell_Previews: PreviewProvider {
    static var previews: some View {
        StartViewCell()
    }
}

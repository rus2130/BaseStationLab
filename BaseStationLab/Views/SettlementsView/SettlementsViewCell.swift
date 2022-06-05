//
//  SettlementsViewCell.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct SettlementsViewCell: View {
    var body: some View {
        card
            .background(Color.blue)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 2)
    }
    
    private var card: some View {
        VStack(spacing: 12) {
            settlementName
            HStack {
                basesCount
                Spacer(minLength: 0)
                lastUpdated
            }
            hardware
        }
        .foregroundColor(.white)
        .font(.system(size: 16, weight: .medium))
        .padding(24)
    }
    
    private var settlementName: some View {
        Text("Рівне")
            .font(.system(size: 18, weight: .bold))
    }
    
    private var basesCount: some View {
        Text("18958")
    }
    
    private var lastUpdated: some View {
        Text("01.01.2022")
    }
    
    private var hardware: some View {
        Text("Huawei: 4566  Erricson: 4416  Інші: 1188")
            .multilineTextAlignment(.center)
    }
}

struct SettlementsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        SettlementsViewCell()
    }
}

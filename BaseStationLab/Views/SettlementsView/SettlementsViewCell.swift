//
//  SettlementsViewCell.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct SettlementsViewCell: View {
    var model: SettlementCellModel
    
    var body: some View {
        card
            .background(model.provider.backgroundColor)
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
        Text(model.settlement)
            .font(.system(size: 18, weight: .bold))
    }
    
    private var basesCount: some View {
        Text(model.baseStationsCountString)
    }
    
    private var lastUpdated: some View {
        Text(model.lastUpdatedString)
    }
    
    private var hardware: some View {
        Text(model.rruNamesString)
            .multilineTextAlignment(.center)
    }
}

struct SettlementsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        SettlementsViewCell(
            model: .init(
                provider: Provider.kyivstar,
                region: "Волинська",
                settlement: "Луцьк",
                baseStationsCount: 1000,
                lastUpdated: Date(),
                rruNames: ["Huawei: 100"]
            )
        )
    }
}

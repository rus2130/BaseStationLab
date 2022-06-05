//
//  RegionsViewCell.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

struct RegionViewCell: View {
    var model: RegionCellModel
    
    var body: some View {
        card
            .background(model.provider.backgroundColor)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 2)
    }
    
    private var card: some View {
        VStack(spacing: 12) {
            regionName
            HStack {
                coverageSection
                Spacer(minLength: 0)
                lastUpdated
            }
            hardware
        }
        .foregroundColor(.white)
        .font(.system(size: 16, weight: .medium))
        .padding(24)
    }
    
    private var coverageSection: some View {
        VStack(spacing: 0) {
            basesCount
            settlements
        }
    }
    
    private var regionName: some View {
        Text(model.regionName)
            .font(.system(size: 18, weight: .bold))
    }
    
    private var basesCount: some View {
        Text(model.baseStationsCountString)
    }
    
    private var settlements: some View {
        Text(model.settlementsCountString)
    }
    
    private var lastUpdated: some View {
        Text(model.lastUpdatedString)
    }
    
    private var hardware: some View {
        Text(model.rruNamesString)
            .multilineTextAlignment(.center)
    }
}

struct RegionsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        RegionViewCell(
            model: .init(
                provider: .kyivstar,
                region: "Київ",
                settlementsCount: 200,
                baseStationsCount: 4000,
                lastUpdated: Date(),
                rruNames: ["Huawei: 100"]
            )
        )
    }
}

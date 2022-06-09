//
//  ComparisonCellView.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 10.06.2022.
//

import SwiftUI

struct ComparisonCellView: View {
    var model: ComparisonCellModel
    
    var body: some View {
        card
            .background(model.provider.backgroundColor)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.4), radius: 8, x: 0, y: 2)
    }
    
    private var card: some View {
        VStack(spacing: 24) {
            HStack(alignment: .top, spacing: 48) {
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
        Text(model.providerString)
            .font(.system(size: 20, weight: .bold))
    }
    
    private var basesCount: some View {
        Text(model.basesCountString)
            .font(.system(size: 20, weight: .bold))
    }
    
    private var lteSection: some View {
        VStack(spacing: 24) {
            providerName
            VStack(spacing: 4) {
                technologyBasesCount(title: "LTE", count: model.lteBasesCountString)
                techologiesBasesCount(technologiesCount: model.sortedLteTechnologies)
            }
        }
    }
    
    private var umtsSection: some View {
        VStack(spacing: 24) {
            basesCount
            VStack(spacing: 4) {
                technologyBasesCount(title: "UMTS", count: model.umtsBasesCountString)
                techologiesBasesCount(technologiesCount: model.sortedUmtsTechnologies)
            }
        }
    }
    
    private var gsmSection: some View {
        VStack(spacing: 4) {
            technologyBasesCount(title: "GSM", count: model.gsmBasesCountString)
            techologiesBasesCount(technologiesCount: model.sortedGsmTechnologies)
        }
    }
    
    private func technologyBasesCount(title: String, count: String) -> some View {
        Text("\(title): \(count)")
            .font(.system(size: 18, weight: .semibold))
    }
    
    private func techologiesBasesCount(technologiesCount: [(technology: String, count: String)]) -> some View {
        VStack(spacing: 2) {
            ForEach(technologiesCount, id: \.technology) { technologyCount in
                Text("\(technologyCount.technology): ") +
                Text(technologyCount.count)
                    .font(.system(size: 16, weight: .semibold))
            }
        }
    }
}

struct ComparisonCellView_Previews: PreviewProvider {
    static var previews: some View {
        ComparisonCellView(
            model: ComparisonCellModel(
                provider: .kyivstar,
                basesCount: 10000,
                lteBasesCount: 10000,
                lteTechnologiesCount: [1000:1000],
                umtsBasesCount: 10000,
                umtsTechnologiesCount: [1000:1000],
                gsmBasesCount: 10000,
                gsmTechnologiesCount: [1000:1000]
            )
        )
    }
}

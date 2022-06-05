//
//  FilterActionSheet.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 06.06.2022.
//

import SwiftUI

struct FilterActionSheet: View {
    @StateObject private var navigationController = NavigationController.shared
    @Binding var isPresented: Bool
    var action: (DetailTechology) -> ()
    
    var body: some View {
        ZStack{}
            .actionSheet(isPresented: $isPresented) {
                actionSheet
            }
    }
    
    private var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Фільтр"),
            message: Text("Оберіть технологію"),
            buttons: getButtons()
        )
    }
    
    private func getButtons() -> [ActionSheet.Button] {
        switch navigationController.filters.currentTechnolody {
        case .lte: return lteButtons
        case .umts: return umtsButtons
        case .gsm: return gsmButtons
        case .all: return umtsButtons
        }
    }
    
    private var lteButtons: [ActionSheet.Button] {
        [
            .default(Text(DetailTechology.all.title)) { makeAction(.all) },
            .default(Text(DetailTechology.lte2600.title)) { makeAction(.lte2600) },
            .default(Text(DetailTechology.lte1800.title)) { makeAction(.lte1800) },
            .default(Text(DetailTechology.lte900.title)) { makeAction(.lte900) },
            .destructive(Text("Скасувати"))
        ]
    }
    
    private var umtsButtons: [ActionSheet.Button] {
        [
            .default(Text(DetailTechology.all.title)) { makeAction(.all) },
            .destructive(Text("Скасувати"))
        ]
    }
    
    private var gsmButtons: [ActionSheet.Button] {
        [
            .default(Text(DetailTechology.all.title)) { makeAction(.all) },
            .default(Text(DetailTechology.gsm1800.title)) { makeAction(.gsm1800) },
            .default(Text(DetailTechology.gsm900.title)) { makeAction(.gsm900) },
            .destructive(Text("Скасувати"))
        ]
    }
    
    private func makeAction(_ technolody: DetailTechology) {
        navigationController.filters.update(detailTechnolody: technolody)
        action(technolody)
    }
}

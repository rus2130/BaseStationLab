//
//  SortActionSheet.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 06.06.2022.
//

import SwiftUI

struct SortActionSheet: View {
    @StateObject private var navigationController = NavigationController.shared
    @Binding var isPresented: Bool
    var action: (SortState) -> ()
    
    var body: some View {
        ZStack{}
            .actionSheet(isPresented: $isPresented) {
                actionSheet
            }
    }
    
    private var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Сортування"),
            message: Text("Оберіть елемент для сортування"),
            buttons: [
                .default(Text(SortState.name.title)) { makeAction(.name) },
                .default(Text(SortState.basesCount.title)) { makeAction(.basesCount) },
                .default(Text(SortState.date.title)) { makeAction(.date) },
                .destructive(Text("Скасувати"))
            ]
        )
    }
    
    private func makeAction(_ sortState: SortState) {
        navigationController.sortState = sortState
        action(sortState)
    }
}


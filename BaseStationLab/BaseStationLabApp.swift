//
//  BaseStationLabApp.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

@main
struct BaseStationLabApp: App {
    @StateObject private var startViewModel = StartViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView(viewModel: startViewModel)
                    .frame(maxWidth: 500)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
                BasesController().checkBasesStatus {
                    startViewModel.getProviderModels()
                }
            }
        }
    }
}

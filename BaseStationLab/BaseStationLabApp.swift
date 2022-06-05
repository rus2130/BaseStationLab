//
//  BaseStationLabApp.swift
//  BaseStationLab
//
//  Created by Ruslan Duda on 05.06.2022.
//

import SwiftUI

@main
struct BaseStationLabApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
                    .frame(maxWidth: 500)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

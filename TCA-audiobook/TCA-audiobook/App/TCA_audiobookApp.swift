//
//  TCA_audiobookApp.swift
//  TCA-audiobook
//
//  Created by Anton Yereshchenko on 26.12.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct pre_test_headway_App: App {
    let store = Store(initialState: Player.State()) {
        Player()._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            PlayerView(store: store)
        }
    }
}

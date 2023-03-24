//
//  ArtWorkAssignmentApp.swift
//  ArtWorkAssignment
//
//  Created by admin on 20/03/2023.
//

import SwiftUI

@main
struct ArtWorkAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ArtworkViewModel(networkManager: NetworkManager()))
            /* dependency injection for network manager for urlsession*/
        }
    }
}

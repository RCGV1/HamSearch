//
//  HamSearchApp.swift
//  HamSearch
//
//  Created by Benjamin Faershtein on 12/24/23.
//

import SwiftUI
import SwiftData

@main
struct HamSearchApp: App {
  
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: DataItem.self)
    }
}

//
//  RapidPrototypeApp.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import SwiftUI

@main
struct RapidPrototypeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

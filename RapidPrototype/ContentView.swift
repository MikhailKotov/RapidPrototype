//
//  ContentView.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: AppDependencyContainer.shared.makeHomeViewModel())
                .tabItem {
                    Label(title: { Text("Home") }, icon: {
                        Image(.home).renderingMode(.template)
                    })
                }

            MeasurementsView()
                .tabItem {
                    Label(title: { Text("Measurements") }, icon: {
                        Image(.documentText).renderingMode(.template)
                    })
                }

            PlanView()
                .tabItem {
                    Label(title: { Text("Plan") }, icon: {
                        Image(.documentList).renderingMode(.template)
                    })
                }

            MoreView()
                .tabItem {
                    Label(title: { Text("More") }, icon: {
                        Image(.moreCircle).renderingMode(.template)
                    })
                }
        }
        .tint(.normalChart)
    }
}

#Preview {
    ContentView()
}


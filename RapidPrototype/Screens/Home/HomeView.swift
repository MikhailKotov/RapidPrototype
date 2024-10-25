//
//  HomeView.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import SwiftUI
import Charts

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Critical Alert
                    if let state = viewModel.selectedUser?.measurements.last?.state, state.showAlert {
                        TopAlertView(state: state)
                    }
                    // Blood Pressure Section
                    if let user = viewModel.selectedUser {
                        SectionHeaderView(
                            title: "Blood Pressure",
                            ofMeasurement: "mmHg",
                            measurements: user.measurements
                        )
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("Home")
            }
            .background(.background2)
            .onAppear{
                viewModel.fetchData()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    let users = viewModel.users
                    Picker("User", selection: $viewModel.selectedUser) {
                        ForEach(users, id: \.self) { user in
                            Text(user.name)
                                .tag(user as UserDTO?)
                                .foregroundStyle(.primaryText)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .clipped()
                    .background(.background1)
                    .tint(.primaryText)
                    .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    HomeView(viewModel: AppDependencyContainer.shared.makePreviewHomeViewModel())
}

#Preview {
    HomeView(viewModel: AppDependencyContainer.shared.makePreviewHomeViewModel()).colorScheme(.dark)
}

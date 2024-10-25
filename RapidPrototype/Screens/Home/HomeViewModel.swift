//
//  HomeViewModel.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let repository: Repository

    @Published var users: [UserDTO] = []
    @Published var selectedUser: UserDTO?
    @Published var isPickerPresented = false

    init(repository: Repository, selectedUser: UserDTO? = nil) {
        self.repository = repository
        self.selectedUser = selectedUser
    }

    func fetchData() {
        Task {
            let fetchedUsers = try await repository.fetchUsers()

            await MainActor.run {
                users = fetchedUsers
                selectedUser = fetchedUsers.first
            }
        }
    }
}

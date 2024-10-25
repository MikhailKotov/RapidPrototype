
//
//  Repository.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import Foundation

protocol Repository {
    func fetchUsers() async throws -> [UserDTO]
}

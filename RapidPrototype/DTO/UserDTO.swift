//
//  UserDTO.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 24/10/2024.
//

import Foundation

struct UserDTO: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let measurements: [MeasurementDTO]
}

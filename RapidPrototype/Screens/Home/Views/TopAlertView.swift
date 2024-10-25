//
//  TopAlertView.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 25/10/2024.
//

import SwiftUI

struct TopAlertView: View {
    var state: PressureMeasurementState
    var body: some View {
        HStack {
            Image(.hexagon)
                .resizable()
                .frame(width: 60, height: 60)
            VStack (alignment: .leading) {
                Text(state.title)
                    .font(.headline)
                Text(state.subtitle)
                    .font(.subheadline)
            }
            .foregroundColor(.alertText)
            Spacer()
        }
        .padding()
        .background(state.alertBackgroundColor)
        .cornerRadius(10)
    }
}

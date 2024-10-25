//
//  NotificationView.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 25/10/2024.
//


import SwiftUI
import Charts

struct NotificationView: View {
    let state: PressureMeasurementState
    var body: some View {
        HStack {
            Image(.hexagonSmall)
                .renderingMode(.template)
            Text(state.subtitle)
                .font(.footnote)
                .padding(.top, 4)
            Spacer()
        }
        .foregroundStyle(state.notificationTextColor)
        .frame(maxWidth: .infinity)
        .padding()
        .background(state.notificationBackgroundColor)
        .cornerRadius(8)
    }
}

#Preview {
    VStack {
        Spacer()
            .frame(height: 100)
        NotificationView(state: .elevated)
        NotificationView(state: .hbps1)
        NotificationView(state: .hbps2)
        NotificationView(state: .critical)
        NotificationView(state: .wrongData)
        Spacer()
    }
    .background(.background2)
    .padding()
}

#Preview {
    VStack {
        Spacer()
            .frame(height: 100)
        NotificationView(state: .elevated)
        NotificationView(state: .hbps1)
        NotificationView(state: .hbps2)
        NotificationView(state: .critical)
        NotificationView(state: .wrongData)
        Spacer()
    }
    .padding()
    .background(.background2)
    .colorScheme(.dark)
}

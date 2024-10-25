//
//  SectionHeaderView.swift
//  RapidPrototype
//
//  Created by Mykhailo Kotov on 25/10/2024.
//


import SwiftUI
import Charts

struct SectionHeaderView: View {
    var title: LocalizedStringKey
    var ofMeasurement: String
    var measurements: [MeasurementDTO]

    @State private var selectedBar: MeasurementDTO?

    private var state: PressureMeasurementState {
        measurements.last?.state ?? .normal
    }

    private var latestValue: LocalizedStringKey {
        guard let measurement = measurements.last else { return "n/a"}
        return measurement.pair
    }

    private var leadingDate: Date {
        (measurements.first?.date ?? Date()).addingTimeInterval(-3600*12)
    }
    
    private var trailingDate: Date {
        (measurements.last?.date ?? Date()).addingTimeInterval(3600*12)
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "heart.circle.fill")
                    .foregroundStyle(.criticalNoteText, .criticalNoteText.opacity(0.4))
                Text(title)
                    .font(.title3)
                    .fontWeight(.medium)
                Spacer()
            }
            Rectangle()
                .fill(.background2)
                .frame(height: 1.0)
                .padding(.bottom, 12)

            HStack {
                VStack (alignment: .leading) {
                    Text("Latest")
                        .font(.subheadline)
                    HStack (alignment: .bottom) {
                        Text(latestValue)
                            .font(.title)
                        Text(ofMeasurement)
                            .font(.subheadline)
                            .padding(.bottom, 3)
                    }
                }
                .foregroundStyle(state.textColor)
            }
            GeometryReader { geometry in
                Chart {
                    ForEach (measurements) { measurement in
                        if selectedBar != measurement,
                           let diastolic = measurement.diastolic,
                           let systolic = measurement.systolic {
                            BarMark(x: .value("Day", measurement.date),
                                    yStart: .value("Pressure", diastolic ),
                                    yEnd: .value("Pressure", systolic),
                                    width: .fixed(4))
                            .cornerRadius(2)
                            .foregroundStyle(measurement.state.chartColor)
                        }
                    }
                    if let selectedBar,
                       let diastolic = selectedBar.diastolic,
                       let systolic = selectedBar.systolic {
                        BarMark(x: .value("Day", selectedBar.date),
                                yStart: .value("Pressure", diastolic ),
                                yEnd: .value("Pressure", systolic),
                                width: .fixed(4))
                        .cornerRadius(2)
                        .foregroundStyle(selectedBar.state.chartColor)
                        .annotation(position: .top) {
                            VStack {
                                HStack (alignment: .bottom, spacing: 2) {
                                    Text("\(systolic, specifier: "%.0f")/\(diastolic, specifier: "%.0f")")
                                        .font(.subheadline)
                                    Text(ofMeasurement)
                                        .font(.caption2)
                                        .padding(.bottom, 1)
                                }
                                .foregroundColor(.white)
                                Text(selectedBar.date.formatted(date: .numeric, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(4)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(5)
                        }
                    }
                }
                .chartXScale(domain: leadingDate...trailingDate)
                .chartYScale(domain: 50...200)
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .padding(.vertical, 20)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded{ _ in selectedBar = nil }
                        .onChanged{ value in
                            let selectedDate = (value.location.x - 26.0) / (geometry.size.width - 26.0)
                            let timeline = trailingDate.timeIntervalSince(leadingDate)
                            let timeValue = leadingDate.addingTimeInterval(timeline * selectedDate)
                            var nearestBar: MeasurementDTO?
                            var interval: TimeInterval = .infinity
                            measurements.forEach { measurement in
                                let newInterval = abs( measurement.date.timeIntervalSince(timeValue))
                                if newInterval < interval {
                                    nearestBar = measurement
                                    interval = newInterval
                                }
                            }
                            selectedBar = nearestBar
                            print(selectedDate)

                        }
                )
            }
            .frame(height: 200)

            if let state = measurements.last?.state, state.showAlert {
                NotificationView(state: state)
            }
        }
        .padding()
        .background(.background1)
        .cornerRadius(10)
    }
}

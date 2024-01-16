//
//  StepsTodayView.swift
//  PedometerTutorial
//
//  Created by Robert Martinez on 1/14/24.
//

import Charts
import SwiftUI

struct StepsTodayView: View {
    @Environment(StepTrackerViewModel.self) var viewModel

    var body: some View {
        VStack {
            Spacer()
            Text("Steps taken today \(viewModel.steps, specifier: "%.0f")")
                .font(.title)

            Spacer()
            Chart {
                BarMark(
                    x: .value("Date", "Today"),
                    y: .value("Steps", viewModel.steps),
                    width: 160
                )
            }
            .frame(height: 400)
            .onAppear {
                viewModel.fetchSteps()
            }
        }
    }
}

#Preview {
    StepsTodayView()
        .environment(StepTrackerViewModel())
}

//
//  ContentView.swift
//  PedometerTutorial
//
//  Created by Robert Martinez on 1/14/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(StepTrackerViewModel.self) var viewModel

    var body: some View {
        VStack {
            if viewModel.isHealthKitAuthorized {
                Text("Steps taken today: \(viewModel.steps, specifier: "%.0f")")
            } else {
                Text("HealthKit authorization required")
                Button("Authorize", action: viewModel.checkHealthKitAuthorization)
            }
        }
        .onAppear {
            viewModel.fetchSteps()
        }
    }
}

#Preview {
    ContentView()
        .environment(StepTrackerViewModel())
}

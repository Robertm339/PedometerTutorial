//
//  PedometerTutorialApp.swift
//  PedometerTutorial
//
//  Created by Robert Martinez on 1/14/24.
//

import SwiftUI

@main
struct PedometerTutorialApp: App {
    @State private var viewModel = StepTrackerViewModel()

    var body: some Scene {
        WindowGroup {
            StepsTodayView()
                .environment(viewModel)
        }
    }
}

//
//  StepTrackerViewModel.swift
//  PedometerTutorial
//
//  Created by Robert Martinez on 1/14/24.
//

import HealthKit
import Observation

@Observable
class StepTrackerViewModel {
    var steps: Double = 0
    var isHealthKitAuthorized: Bool = false

    var stepTracker = StepTracker()

    init() {
        checkHealthKitAuthorization()
    }

    func checkHealthKitAuthorization() {
        guard stepTracker.isHealthKitAvailable else {
            // HealthKit is not available on this device
            return
        }

        stepTracker.authorizeHealthKit { [weak self] success, error in
            DispatchQueue.main.async {
                self?.isHealthKitAuthorized = success
                if success {
                    self?.fetchSteps()
                } else {
                    // Handle errors
                }
            }
        }
    }

    func fetchSteps() {
        stepTracker.queryStepCount { [weak self] steps, error in
            DispatchQueue.main.async {
                if let steps = steps {
                    self?.steps = steps
                } else {
                    // Handle errors or update the UI accordingly
                }
            }
        }
    }
}


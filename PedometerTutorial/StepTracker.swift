//
//  StepTracker.swift
//  PedometerTutorial
//
//  Created by Robert Martinez on 1/14/24.
//

import HealthKit

struct StepTracker {
    let healthStore = HKHealthStore()

    var isHealthKitAvailable: Bool {
        return HKHealthStore.isHealthDataAvailable()
    }

    func authorizeHealthKit(completion: @escaping (Bool, Error?) -> Void) {
        guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(false, NSError(domain: "com.example.HealthKit", code: 2, userInfo: [NSLocalizedDescriptionKey: "HealthKit not available"]))
            return
        }

        healthStore.requestAuthorization(toShare: [], read: Set([stepType])) { success, error in
            completion(success, error)
        }
    }

    func queryStepCount(completion: @escaping (Double?, Error?) -> Void) {
         let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
         let now = Date()
         let startOfDay = Calendar.current.startOfDay(for: now)
         let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)

         let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, statistics, error in
             if let error = error {
                 completion(nil, error)
                 return
             }

             if let sum = statistics?.sumQuantity() {
                 let steps = sum.doubleValue(for: HKUnit.count())
                 completion(steps, nil)
             }
         }

         healthStore.execute(query)
     }
}

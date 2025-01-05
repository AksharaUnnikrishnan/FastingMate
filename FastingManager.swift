//
//  FastingManager.swift
//  FastingMate
//
//  Created by Akshara Unnikrishnan on 04/01/25.
//

import Foundation

enum FastingState {
    case notStarted
    case fasting
    case feeding
}

enum FastingPlan: String {
    case beginner = "12:12"
    case intermediate = "16:8"
    case advanced = "20:4"
    
    var fastingPeriod: Double {
        switch self {
        case .beginner:
            12
        case .intermediate:
            16
        case .advanced:
            20
        }
    }
}

class FastingManager: ObservableObject {
    @Published private(set) var fastingState: FastingState = .notStarted
    @Published private(set) var fastingPlan: FastingPlan = .intermediate
    @Published private(set) var startTime: Date {
        didSet {
            if fastingState == .fasting {
                endTime = startTime.addingTimeInterval(fastingTime)
            } else {
                endTime = startTime.addingTimeInterval(feedingTime)
            }
        }
    }
    @Published private(set) var endTime: Date
    @Published private(set) var elapsed: Bool = false
    @Published private(set) var elapsedTime: Double = 0.0
    @Published private(set) var progress: Double = 0.0
    var fastingTime: Double {
        fastingPlan.fastingPeriod * 60 * 60
    }
    
    var feedingTime: Double {
        24 - fastingPlan.fastingPeriod * 60 * 60
    }
    init() {
        let calender = Calendar.current
        let components = DateComponents(hour: 20)
        let scheduledTime = calender.nextDate(after: .now, matching: components, matchingPolicy: .nextTime)!
        startTime = scheduledTime
        endTime = scheduledTime.addingTimeInterval(FastingPlan.intermediate.fastingPeriod * 60 * 60) 
    }
    
    func toggleFastingState() {
        fastingState = fastingState == .fasting ? .feeding : .fasting
        startTime = Date()
        elapsedTime = 0.0
    }
    
    func track() {
        guard fastingState != .notStarted else { return }
        if endTime >= .now {
            print("not elapsed")
            elapsed = false
        } else {
            print("elapsed")
            elapsed = true
        }
        elapsedTime += 1
        let totalTime = fastingState == .fasting ? fastingTime : feedingTime
        progress = (elapsedTime/totalTime * 100).rounded() / 100
    }
}

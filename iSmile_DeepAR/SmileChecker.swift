//
//  SmileChecker.swift
//  iSmile_DeepAR
//
//  Created by Marco Visentin on 2/1/24.
//

import Foundation


class SmileChecker {
    private var timer: Timer?
    private let threshold: TimeInterval = 1.2 // 3 seconds
    var success: Bool = false
    var isDetectionActive: Bool = true

    var isSmiling: Bool = false {
        didSet {
            // Only respond to changes in isSmiling if isDetectionActive is true
            if isDetectionActive {
                if isSmiling {
                    startTimer()
                } else {
                    resetTimer()
                }
            }
        }
    }

    private func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: threshold, repeats: false) { [weak self] _ in
                self?.success = true
                self?.isDetectionActive = false
            }
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        timer = nil // not sure it is necessary
    }
}

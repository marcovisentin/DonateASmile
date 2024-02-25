//
//  FilterApplier.swift
//  iSmile_DeepAR
//
//  Created by Marco Visentin on 2/1/24.
//

import Foundation
import Combine
import DeepAR

class FilterApplier {
    
    private var filterTimer: Timer?
    private var filterTimeThreshold: TimeInterval  = 8.0
    var isFilterOn: Bool = false
    
    func applyFilter(to deepAR: DeepAR) {
        isFilterOn = true
        addFilter(to: deepAR)
    }
    
    
    private func addFilter(to deepAR: DeepAR) {
        deepAR.switchEffect(withSlot: "face", path: Bundle.main.path(forResource: "rayban_glass", ofType: "deepar"))
        self.startRemoveFilterTimer(deepAR: deepAR)
    }
    
    
    private func startRemoveFilterTimer(deepAR: DeepAR) {
        print("Start filters removing")
        filterTimer = Timer.scheduledTimer(withTimeInterval: filterTimeThreshold, repeats: false) { [weak self] _ in
            deepAR.switchEffect(withSlot: "face", path: Bundle.main.path(forResource: "InvisibleEmotions", ofType: "deepar"))
            self?.filterTimer?.invalidate()
            self?.filterTimer = nil
            self?.isFilterOn = false
            }
        }
    }
    

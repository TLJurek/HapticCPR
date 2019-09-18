//
//  HapticGuidance.swift
//  HapticCPR
//
//  Created by Tomasz Jurek on 03/04/2019.
//  Copyright © 2019 Tomasz Jurek. All rights reserved.
//

import Foundation
import UIKit

class HapticGuidance{
    
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    var timer: Timer?
    
    func startHapticGuidance(){
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hapticRefresh), userInfo: nil, repeats: true)
        //0.5 is interval due to 60/110BPM
    }
    
    @objc func hapticRefresh(){
        generator.prepare()
        generator.impactOccurred()
    }
    
    func stopHapticGuidance(){
        timer?.invalidate()
    }
}

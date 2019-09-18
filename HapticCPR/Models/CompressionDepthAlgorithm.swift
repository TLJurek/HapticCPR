//
//  CompressionDepthAlgorithm.swift
//  HapticCPR
//
//  Created by Tomasz Jurek on 03/04/2019.
//  Copyright © 2019 Tomasz Jurek. All rights reserved.
//

import Foundation
import CoreMotion

class CompressionDepthAlgorithm{
    var motionManager = CMMotionManager()
    var depth: Double = 0.0
    var depthTotal: Double = 0.0
    var depthCounter: Int = 0
    
    func startCompressionDepthMeasurement(){
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!)
        {
            (data, error) in if let myData = data
            {
                if myData.acceleration.z <= -1.2{
                    let compressionDepthAcc:Double = myData.acceleration.z
                    let result = Double(compressionDepthAcc) * -2.8
                    self.depth = result
                    self.depthCounter+=1
                    self.depthTotal = self.depthTotal + self.depth
                    print("\(String(format: "%.2f", result)) mm") //Console debugging
                }
            }
        }
    }
    
    func getCompressionDepth() -> Double{
        return self.depth
    }
    
    func getAverageDepth() -> Double {
        var averageDepth: Double = 0.0
        if depthTotal == 0 || depthCounter == 0 {
            return averageDepth
        }
        averageDepth = self.depthTotal/Double(self.depthCounter)
        self.depthTotal = 0.0
        self.depthCounter = 0
        return averageDepth
    }
    
    func stopCompressionDepthMeasurement(){
        motionManager.stopAccelerometerUpdates()
    }
}

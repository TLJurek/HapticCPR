//
//  CompressionRateAlgorithm.swift
//  HapticCPR
//
//  Created by Tomasz Jurek on 12/02/2019.
//  Copyright © 2019 Tomasz Jurek. All rights reserved.
//

import Foundation
import CoreMotion


class CompressionRateAlgorithm{
    
    var motionManager = CMMotionManager()
    var totalCompressionsCounter = 0
    var compressionCounter = 0
    
    func startCompressionRateMeasurement(){
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!)
        {
            (data, error) in if let myData = data
            {
                //print(myData)
                //taps into all the logs
                
                if myData.acceleration.z <= -1.2{
                    self.totalCompressionsCounter+=1
                    self.compressionCounter+=1
                    print("Successful Compression - \(self.totalCompressionsCounter)") //console debugging
                }
            }
        }
    }
    
    func calculateBPM(_ refreshIntervalSeconds: Int)->Int{
        let BPM: Int = self.compressionCounter*refreshIntervalSeconds
        self.compressionCounter = 0
        return BPM
        }
    
    func stopCompressionRateMeasurement(){
        motionManager.stopAccelerometerUpdates()
    }
    
}

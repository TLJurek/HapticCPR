//
//  GuidanceViewController.swift
//  HapticCPR
//
//  Created by Tomasz Jurek on 07/02/2019.
//  Copyright © 2019 Tomasz Jurek. All rights reserved.
//

import UIKit
import Foundation

class GuidanceViewController: UIViewController {
    
    @IBOutlet weak var labelCPRGuidance: UILabel!
    @IBOutlet weak var labelRateBPM: UILabel!
    @IBOutlet weak var labelDepth: UILabel!
    @IBOutlet weak var labelVisualGuidance: UILabel!
    @IBOutlet weak var buttonStopCPRGuidance: UIButton!
    
    let TIMER_REFRESH: Double = 10
    var compressionRate = CompressionRateAlgorithm()
    var compressionDepth = CompressionDepthAlgorithm()
    var sound = SoundGuidance()
    var haptic = HapticGuidance()
    var visual = VisualGuidance()
    var settings = Settings()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: TIMER_REFRESH, target: self, selector: #selector(self.updateLabels), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateLabels(){
        let BPM = compressionRate.calculateBPM(60/Int(TIMER_REFRESH))
        let Depth = compressionDepth.getAverageDepth()
        self.labelRateBPM.text = String(BPM)
        self.labelDepth.text = String(format: "%.2f", Depth)
        
        if settings.getVisualGuidanceSetting(){
            visual.startVisualGuidance(Depth, BPM)
        }
        
        self.labelVisualGuidance.text = visual.getVisualGuidance()
        if BPM < 110{
            labelRateBPM.textColor = UIColor.red
        }
        else if BPM >= 110 && BPM <= 120{
            labelRateBPM.textColor = UIColor.green
        }
        else if BPM > 120{
            labelRateBPM.textColor = UIColor.yellow
        }
        
        if Depth < 4.0 {
            labelDepth.textColor = UIColor.red
        }
        else if Depth >= 4.0 && Depth <= 5.00 {
            labelDepth.textColor = UIColor.green
        }
        else if Depth > 5.00 {
            labelDepth.textColor = UIColor.yellow
        }
        
        if settings.getSoundGuidanceSetting(){
            sound.initateSoundGuidance(Depth, BPM)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        compressionRate.startCompressionRateMeasurement()
        compressionDepth.startCompressionDepthMeasurement()
        self.labelVisualGuidance.text = visual.getVisualGuidance()
        
        if settings.getHapticGuidanceSetting(){
            haptic.startHapticGuidance()
        }
    }
    
    @IBAction func buttonStopGuidance(_ sender: Any) {
        compressionRate.stopCompressionRateMeasurement()
        compressionDepth.stopCompressionDepthMeasurement()
        haptic.stopHapticGuidance()
        timer?.invalidate()
        
    }
}

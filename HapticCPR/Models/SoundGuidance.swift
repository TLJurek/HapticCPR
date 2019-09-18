//
//  SoundGuidance.swift
//  HapticCPR
//
//  Created by Tomasz Jurek on 03/04/2019.
//  Copyright © 2019 Tomasz Jurek. All rights reserved.
//

import Foundation
import AVFoundation

class SoundGuidance{
    
    var audioPlayer : AVAudioPlayer!
    
    func playAlert(_ alertName: String, _ alertNameFileExtension: String){
        let soundURL = Bundle.main.url(forResource: alertName, withExtension: alertNameFileExtension)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }catch{
            print(error)
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func initateSoundGuidance(_ depth: Double, _ BPM: Int){
        if BPM < 110{
            playAlert("speedUp", "m4a")
        } else if BPM >= 110 && BPM <= 120{
            playAlert("goodPace", "m4a")
        } else if BPM > 120{
            playAlert("slowDown", "m4a")
        }
        
        sleep(1) //BPM Alerts take exactly 1 second, thus creating delay for next alert is natural
        
        if depth < 4.0 {
            playAlert("pressHarder", "m4a")
        } else if depth >= 4.0 && depth <= 5.00 {
            playAlert("goodPresses", "m4a")
        } else if depth > 5.00 {
            playAlert("pressSofter", "m4a")
        }
    }
}

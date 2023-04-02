//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var eggTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timer = Timer()
    let eggTimes = ["Soft": 300.0, "Medium": 420.0, "Hard": 720.0]
    var totalTime = 0.0
    var secondsPassed = 0.0
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        secondsPassed = 0.0
        progressBar.progress = 0.0
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        eggTitle.text=hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer()
    {
        if secondsPassed<totalTime{
            secondsPassed+=1
            progressBar.progress = Float(secondsPassed)/Float(totalTime)
            
        } else if(secondsPassed == totalTime) {
            timer.invalidate()
            eggTitle.text = "Done!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                        player = try! AVAudioPlayer(contentsOf: url!)
                        player.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.eggTitle.text="How do you like your eggs?"
            }
            let haptics=UIImpactFeedbackGenerator()
            haptics.impactOccurred()
        }
    }
}

//
//  ViewController.swift
//  EggTimer
//
//  Original code author: Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // soft: 3*60,med: 4*60,hard: 7*60
    let eggTimes = ["Soft":3, "Medium":4, "Hard":7]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var progressStatus: Float?
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        // shows the title of the button pressed
        let hardness = sender.currentTitle!
        
        // Reset
        totalTime = eggTimes[hardness]!
        secondsPassed = 0
        progressStatus = 0.0
        titleLabel.text = hardness
        
        // timer
        timer = Timer.scheduledTimer(timeInterval:1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    // update progress bar every certain timeInterval:1.0
    @objc func update() {
        progressStatus = Float(secondsPassed) / Float(totalTime)
        progressBar.progress = progressStatus!
        
        if(self.secondsPassed < totalTime)
        {
            print("\(self.secondsPassed) seconds passed")
            self.secondsPassed += 1
        }
        else
        {
            timer.invalidate()
            titleLabel.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

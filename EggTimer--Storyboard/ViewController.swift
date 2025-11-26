    //
    //  ViewController.swift
    //  EggTimer--Storyboard
    //
    //  Created by Michael George on 26/11/2025.
    //

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    
    let eggTime: [String: Int] = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var secondPassed = 0
    var totalTime = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    
    @IBAction func hardnessSelectedBtn(_ sender: UIButton) {
        timer.invalidate()
        
        guard let hardness = sender.currentTitle else { return }
        guard let time = eggTime[hardness] else { return }
        
        titleLabel.text = "Cracking Egg..."
        
        totalTime = time
        secondPassed = 0        // أهمّ سطر كان ناقص
        
        timerProgress.progress = 0
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error loading sound file")
        }
    }
    
    
    @objc func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            
            let progress = Float(secondPassed) / Float(totalTime)
            timerProgress.progress = progress
            
        } else {
            timer.invalidate()
            titleLabel.text = "BOOM!"
            timerProgress.progress = 1
            playSound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerProgress.progress = 0
    }
}

//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("main thread name: \(Thread.main.name!)")
    }

    func playSound(res: String, ext: String) {
        //setupSession()
                
        let url = Bundle.main.url(forResource: res, withExtension: ext)
        player = try! AVAudioPlayer(contentsOf: url!)
        
        print("prepared to play: \(player.prepareToPlay())")
        print("playback started: \(player.play())")
    }
    
    func setupSession() {
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSession.Category.playback)
        try! session.setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
    }

    @IBAction func onKeyPressed(_ sender: UIButton) {
        let name = sender.currentTitle!
        let ext = "wav"
        
        print("trying to play \(name + "." + ext)")
        
        playSound(res: name, ext: ext)
        
        let interval = 2.5
        
        sender.alpha = 0.5
        performWithDelay(code: {
            sender.alpha = 1
        }, seconds: interval)
    }
    
    func performWithDelay(code: @escaping () -> Void, seconds: Double) {
        let t = Thread.init {
            //let cur = Thread.current
            
            Thread.sleep(forTimeInterval: seconds)
                            
            RunLoop.main.perform(code)
        }

        t.name = "my_thread_1"
        
        t.start()
    }

}


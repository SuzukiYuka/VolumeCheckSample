//
//  ViewController.swift
//  VolumeCheckSample
//
//  Created by nagata on 12/8/16.
//  Copyright © 2016 nagata. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, RBDMuteSwitchDelegate {
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            
            try audioSession.setActive(true)
        } catch {
            
            print("Error setActive")
        }
        
        
        // observer追加
        audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.New, context: nil)
        
        //
        print("端末のvolumeは\(audioSession.outputVolume)")
        
        let muteSwitch = RBDMuteSwitch.sharedInstance()
        muteSwitch.delegate = self
        muteSwitch.detectMuteSwitch()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "outputVolume"{
            
            print(change!["new"])
        }
    }
    
    
    func isMuted(muted: Bool) {
        
        print("the device is in silent mode ... \(muted)")
    }
}

//
//  ViewController.swift
//  Udemy-Swift-Audio-86
//
//  Created by Lam Quoc on 2/27/16.
//  Copyright © 2016 Lam Quoc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let audioPath = NSBundle.mainBundle().pathForResource("nguoitanoi", ofType: "mp3")
        do{
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
            scrubSlide.maximumValue = Float(player.duration)
            
            _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateScrub"), userInfo: nil, repeats: true)
        }catch{
            //Error here
        }
        
    }
    
    func updateScrub(){
        scrubSlide.value = Float(player.currentTime)
    }
    
    
    @IBOutlet weak var slideVolume: UISlider!
    
    @IBAction func changeVolume(sender: AnyObject) {
        player.volume = roundf(slideVolume.value)
    }
    
    @IBOutlet weak var scrubSlide: UISlider!
    
    @IBAction func scrubAction(sender: AnyObject) {
        player.currentTime = NSTimeInterval(scrubSlide.value)
        print(player.currentTime)
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButton(sender: AnyObject) {
        player.play()
        
    }
    
    
    @IBAction func pause(sender: AnyObject) {
     player.pause()
    }
    
    
    @IBAction func stop(sender: AnyObject) {
        player.stop()
    }
}


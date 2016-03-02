//
//  ViewController.swift
//  Udemy-Swift-Audio-84
//
//  Created by Lam Quoc on 2/27/16.
//  Copyright © 2016 Lam Quoc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player:AVAudioPlayer = AVAudioPlayer()
    
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func play(sender: AnyObject) {
        player.play()
    }

    @IBAction func pause(sender: AnyObject) {
        player.pause()
    }
    
    @IBAction func changeVolume(sender: AnyObject) {
        
        let tempVar = roundf(slider.value)
        
        player.volume = tempVar
        print(slider.value)
        
        print(tempVar)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let audioPath = NSBundle.mainBundle().pathForResource("nguoitanoi", ofType: "mp3")
        
        do{
            
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath!))
            
        }catch{
            //Error
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


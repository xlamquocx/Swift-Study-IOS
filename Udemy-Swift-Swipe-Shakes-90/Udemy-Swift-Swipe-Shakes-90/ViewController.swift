//
//  ViewController.swift
//  Udemy-Swift-Swipe-Shakes-90
//
//  Created by Lam Quoc on 2/27/16.
//  Copyright © 2016 Lam Quoc. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    var player:AVAudioPlayer = AVAudioPlayer()
    
    var sounds = ["bean","belch","giggle","pew","pig","snore","static","uuu"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }

    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake{
            print("Device was shaken")
            
            let randomNumber = Int(arc4random_uniform(UInt32(sounds.count)))
            
            let fileLoaction = NSBundle.mainBundle().pathForResource(sounds[randomNumber], ofType: "mp3")
//            var error:NSError? = nil
            do{
                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: fileLoaction!))
                player.play()
            }catch{
                //Error
            }
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


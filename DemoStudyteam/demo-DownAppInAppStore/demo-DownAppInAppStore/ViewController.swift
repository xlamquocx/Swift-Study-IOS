//
//  ViewController.swift
//  demo-DownAppInAppStore
//
//  Created by Lam Quoc on 3/4/16.
//  Copyright © 2016 Lam Quoc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func link1(sender: UIButton) {
        let iTunesLink = "itms://itunes.apple.com/de/app/x-gift/id839686104?mt=8&uo=4"
        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        
        
        var url:NSURL   = NSURL()
        
        url = NSURL(string: iTunesLink)!
        
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func link2(sender: UIButton) {
        //https://itunes.apple.com/us/app/solitaire/id359917414?mt=8
        let iTuneLink = "itms://itunes.apple.com/us/app/solitaire/id359917414?mt=8"
        var url:NSURL = NSURL()
        url = NSURL(string: iTuneLink)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    @IBAction func link3(sender: UIButton) {
        //itms://itunes.apple.com/us/app/charades!-free/id653967729?mt=8
        let iTunelink = "itms://itunes.apple.com/us/app/charades!-free/id653967729?mt=8"
        let url:NSURL = NSURL(string: iTunelink)!
        
        UIApplication.sharedApplication().openURL(url)
        
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        print(bundleIdentifier!)
        
    }
    
    @IBAction func link4(sender: UIButton) {
//        print(NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String)
        UIApplication.sharedApplication().canOpenURL(NSURL(string: "")!)
    }
    
    @IBAction func btn5(sender: AnyObject) {
        let url:NSURL = NSURL(string: "q://")!
        
        UIApplication.sharedApplication().openURL(url)
    }
    
    
}


//
//  AboutUsViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import Social
import SCLAlertView

class AboutUsViewController: UIViewController {
    
    let webpage = "https://peaceful-gorge-92356.herokuapp.com/"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "About Us"
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // lock the rotation
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.shouldRotate = false
        
        // Force the device in landscape mode when the view controller gets loaded
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.shouldRotate = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    @IBAction func twPressed(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {            
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetShare.setInitialText("Hi there! - I am using Pet Finder app and I think It's awesome")
            tweetShare.addURL(NSURL(string: webpage))
            
            self.presentViewController(tweetShare, animated: true, completion: nil)
            
        } else {
            SCLAlertView().showWarning("Can't share message", subTitle: "Please login to a Twitter account to tweet.")
        }
    }

    @IBAction func fbPressed(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbShare.setInitialText("Hi there! - I am using Pet Finder app and I think It's awesome")
            fbShare.addURL(NSURL(string: webpage))
                
            self.presentViewController(fbShare, animated: true, completion: nil)
            
        } else {
            SCLAlertView().showWarning("Can't share message", subTitle: "Please login to a Facebook account to share.")
        }
    }
    @IBAction func webLinkPressed(sender: AnyObject) {
        if let url = NSURL(string: webpage){
            UIApplication.sharedApplication().openURL(url)
        }
    }
}

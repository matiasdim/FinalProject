//
//  ReportPetViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import SwiftQRCode

class ReportPetViewController: UIViewController {

    let scanner = QRCode()
    var qrString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Scan QR Code"
        self.navigationController?.navigationBar.hidden = false
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
            dispatch_async(dispatch_get_main_queue(), {
                self.qrString = stringValue //"2"// = stringValue
                self.performSegueWithIdentifier("createReportSegue", sender: self)
            })
            
        }
        // test scan frame
        scanner.scanFrame = view.bounds
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.shouldRotate = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! CreateReportViewController
        vc.qrString = self.qrString
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        // lock the rotation
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.shouldRotate = false
        
        // Force the device in landscape mode when the view controller gets loaded
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        
        scanner.startScan()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }    
}

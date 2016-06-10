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

        self.navigationItem.title = "Report Pet"
        self.navigationController?.navigationBar.hidden = false
//        scanner.prepareScan(view) { (stringValue) -> () in
//            print(stringValue)
//            dispatch_async(dispatch_get_main_queue(), {
                self.qrString = "1"// stringValue
                self.performSegueWithIdentifier("createReportSegue", sender: self)
//            })
//            
//        }
        // test scan frame
        scanner.scanFrame = view.bounds

        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! CreateReportViewController
        vc.qrString = self.qrString
    }
    
    override func viewDidAppear(animated: Bool) {
        scanner.startScan()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

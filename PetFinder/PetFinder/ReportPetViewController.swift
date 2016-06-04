//
//  ReportPetViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ReportPetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !Defaults.hasKey(.userAuthenticated) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("loginVC")
            self.navigationController?.pushViewController(vc, animated: false)
        }

        self.navigationItem.title = "Report Pet Found"
        self.navigationController?.navigationBar.hidden = false

        // Do any additional setup after loading the view.
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

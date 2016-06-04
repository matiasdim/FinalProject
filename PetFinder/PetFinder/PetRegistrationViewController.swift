//
//  PetRegistrationViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class PetRegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Register your Pet"
        if !Defaults.hasKey(.userAuthenticated) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("loginVC")
            self.navigationController?.pushViewController(vc, animated: false)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        view.endEditing(true)
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

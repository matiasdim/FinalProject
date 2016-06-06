    //
//  LoginViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import RappleProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
    }
    

    @IBAction func sendPressed(sender: AnyObject) {
        RappleActivityIndicatorView.startAnimatingWithLabel("Loging user...", attributes: RappleAppleAttributes)
        User(email: email.text!, password: password.text!)?.login(
            { (response) in
                Defaults[.userAuthenticated] = true
                let userObject: Dictionary = (response as? Dictionary<String, AnyObject>)!
                Defaults[.emailKey] = userObject["email"] as! String
                    
                dispatch_async(dispatch_get_main_queue(),{
                    RappleActivityIndicatorView.stopAnimating()
                    self.navigationController?.popViewControllerAnimated(false)
                    //self.navigationController?.popToRootViewControllerAnimated(false)
                })
            },
            failCallback: { (error) in
                dispatch_async(dispatch_get_main_queue(),{
                    RappleActivityIndicatorView.stopAnimating()
                    let alert = UIAlertController(title: "Alert", message: "Login error. \n Try again!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
        })
    }
    
    @IBAction func signupPressed(sender: AnyObject) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("signupVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func closePressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(false)
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

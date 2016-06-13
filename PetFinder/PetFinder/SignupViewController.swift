//
//  SignupViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import RappleProgressHUD

class SignupViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign Up"
        
        let reportButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(SignupViewController.sendPressed))
        self.navigationItem.rightBarButtonItem = reportButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(SignupViewController.cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func sendPressed()
    {
        if (email.text?.isEmpty)! || (password.text?.isEmpty)! || (name.text?.isEmpty)! || (mobile.text?.isEmpty)! {
            let alert = UIAlertController(title: "Alert", message: "You must provide a username, password, name and mobile number.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let user = User.init(email: email.text!, password: password.text!, mobile: mobile.text!, name: name.text!)
            if user!.isValidEmail() && user!.isValidPassword() {
                RappleActivityIndicatorView.startAnimatingWithLabel("Registring user...", attributes: RappleAppleAttributes)
                user?.create(
                    { (response) in
                        Defaults[.userAuthenticated] = true
                        let userObject: Dictionary = (response as? Dictionary<String, AnyObject>)!
                        Defaults[.emailKey] = userObject["email"] as! String
                        Defaults[.nameKey] = userObject["name"] as! String
                        Defaults[.reportsNumberKey] = 0
                        
                        dispatch_async(dispatch_get_main_queue(),{
                            RappleActivityIndicatorView.stopAnimating()
                            self.navigationController?.popToRootViewControllerAnimated(false)
                        })
                    },
                    failCallback: { (error) in
                        dispatch_async(dispatch_get_main_queue(),{
                            RappleActivityIndicatorView.stopAnimating()
                            let alert = UIAlertController(title: "Alert", message: "Sign up error. \n Try again!", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                        })
                })
            }else{
                let alert = UIAlertController(title: "Alert", message: "Email must have correct format and password must not have less than 8 characters.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
        }
    }
    
    func cancelPressed()
    {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

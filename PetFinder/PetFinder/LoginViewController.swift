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
import SCLAlertView

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myTextFields = [UITextField]()
        
        myTextFields = [email, password]
        for item in myTextFields {
            item.setPreferences()
        }
        signUpButton.setPreferences()
        
        self.navigationItem.title = "Login"
        let reportButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(SignupViewController.sendPressed))
        self.navigationItem.rightBarButtonItem = reportButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(SignupViewController.cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        reportButton.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 17.0)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()],
                                          forState: UIControlState.Normal)
        cancelButton.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 17.0)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()],
                                            forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    // MARK: - Button actions
    @IBAction func signupPressed(sender: AnyObject) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("signupVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Other functions
    func sendPressed()
    {
        self.view.endEditing(true)
        if (email.text?.isEmpty)! || (password.text?.isEmpty)! {
            SCLAlertView().showError("Error", subTitle: "You must provide a username and password.")
        }else{
            if NetworkManager.isInternetReachable(){
                let user = User(email: email.text!, password: password.text!)
                if user!.isValidEmail() && user!.isValidPassword() {
                    RappleActivityIndicatorView.startAnimatingWithLabel("Loging user...", attributes: RappleAppleAttributes)
                    user!.login(
                        { (response) in
                            dispatch_async(dispatch_get_main_queue(),{[unowned self] in
                                RappleActivityIndicatorView.stopAnimating()
                                Defaults[.userAuthenticated] = true
                                let userObject: Dictionary = (response as? Dictionary<String, AnyObject>)!
                                Defaults[.emailKey] = userObject["email"] as! String
                                Defaults[.nameKey] = userObject["name"] as! String
                                Defaults[.reportsNumberKey] = userObject["reports_count"] as! Int
                                self.navigationController?.popViewControllerAnimated(false)
                                })
                        },
                        failCallback: { (error) in
                            dispatch_async(dispatch_get_main_queue(),{
                                RappleActivityIndicatorView.stopAnimating()
                                SCLAlertView().showError("Error", subTitle: "Login error. \n Try again!")
                            })
                    })
                }else{
                    SCLAlertView().showError("Error", subTitle: "Email must have correct format and password must not have less than 8 characters.")
                }
            }else{
                SCLAlertView().showWarning("Alert", subTitle: "There isn't internet connection. Please connect to internet and try again.")
            }
        }
    }
    
    func cancelPressed()
    {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
}

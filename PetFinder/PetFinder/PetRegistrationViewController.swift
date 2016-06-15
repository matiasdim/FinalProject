//
//  PetRegistrationViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import RappleProgressHUD
import SCLAlertView

class PetRegistrationViewController: UIViewController {


    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var observationText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Register Pet"
        let borderColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        observationText.layer.borderColor = borderColor.CGColor;
        observationText.layer.borderWidth = 0.5;
        observationText.layer.cornerRadius = 5.0;
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        if !Defaults.hasKey(.userAuthenticated) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("loginVC")
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    @IBAction func sendPressed(sender: AnyObject) {
        self.view.endEditing(true)
        if (nameText.text?.isEmpty)! {
            SCLAlertView().showError("Error", subTitle: "You need provide the name of your pet.")
//            let alert = UIAlertController(title: "Alert", message: "You need provide the name of your pet", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            if NetworkManager.isInternetReachable(){
                RappleActivityIndicatorView.startAnimatingWithLabel("Creating pet...", attributes: RappleAppleAttributes)
                let pet = Pet()
                pet.email = Defaults[.emailKey]
                pet.observations = observationText.text!
                pet.name = nameText.text!
                pet.create(
                    { (response) in
                        dispatch_async(dispatch_get_main_queue(),{
                            RappleActivityIndicatorView.stopAnimating()
                            
                            let appearance = SCLAlertView.SCLAppearance(
                                showCloseButton: false
                            )
                            let alertView = SCLAlertView(appearance: appearance)
                            alertView.addButton("OK") {
                                self.navigationController?.popToRootViewControllerAnimated(false)
                            }
                            alertView.showSuccess("Success", subTitle: "Pet successfully created.")
                            
//                            let alert = UIAlertController(title: "Success", message: "Pet successfully created", preferredStyle: UIAlertControllerStyle.Alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
//                                self.navigationController?.popToRootViewControllerAnimated(false)
//                            }))
//                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        })
                    }, failCallback: { (error) in
                        dispatch_async(dispatch_get_main_queue(),{
                            RappleActivityIndicatorView.stopAnimating()
                            SCLAlertView().showError("Error", subTitle: "Error creating pet. Try again!")

//                            let alert = UIAlertController(title: "Alert", message: "Error creating pet. Try again!", preferredStyle: UIAlertControllerStyle.Alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                            self.presentViewController(alert, animated: true, completion: nil)
                        })
                })
            }else{
                SCLAlertView().showWarning("Alert", subTitle: "There isn't internet connection. Please connect to internet and try again.")
//                let ac = UIAlertController(title: "Alert", message: "There isn't internet connection. Please connect to internet and try again.", preferredStyle: .Alert)
//                ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//                presentViewController(ac, animated: true, completion: nil)
            }
        }
    }
}

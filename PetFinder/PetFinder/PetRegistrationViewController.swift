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
    @IBOutlet weak var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        nameText.setPreferences()
        observationText.setPreferences()
        
        sendButton.setPreferences()
        
        self.navigationItem.title = "Register Pet"
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // MARK: - Button actions
    @IBAction func sendPressed(sender: AnyObject) {
        self.view.endEditing(true)
        if (nameText.text?.isEmpty)! {
            SCLAlertView().showError("Error", subTitle: "You need provide the name of your pet.")
        }else{
            if NetworkManager.isInternetReachable(){
                RappleActivityIndicatorView.startAnimatingWithLabel("Creating pet...", attributes: RappleAppleAttributes)
                let pet = Pet()
                pet.email = Defaults[.emailKey]
                pet.observations = observationText.text!
                pet.name = nameText.text!
                pet.create(
                    { (response) in
                        dispatch_async(dispatch_get_main_queue(),{[unowned self] in
                            RappleActivityIndicatorView.stopAnimating()
                            
                            let appearance = SCLAlertView.SCLAppearance(
                                showCloseButton: false
                            )
                            let alertView = SCLAlertView(appearance: appearance)
                            alertView.addButton("OK") {
                                self.navigationController?.popToRootViewControllerAnimated(false)
                            }
                            alertView.showSuccess("Success", subTitle: "Pet successfully created.")
                        })
                    }, failCallback: { (error) in
                        dispatch_async(dispatch_get_main_queue(),{
                            RappleActivityIndicatorView.stopAnimating()
                            SCLAlertView().showError("Error", subTitle: "Error creating pet. Try again!")
                        })
                })
            }else{
                SCLAlertView().showWarning("Alert", subTitle: "There isn't internet connection. Please connect to internet and try again.")
            }
        }
    }
}

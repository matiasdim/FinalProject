//
//  HomeViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/29/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//
/// qrIcon: http://www.flaticon.com/free-icon/

import UIKit
import SwiftyUserDefaults

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "How it works"

        self.navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(SignupViewController.cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        cancelButton.setTitleTextAttributes([
            NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 17.0)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()],
                                            forState: UIControlState.Normal)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func cancelPressed()
    {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
}
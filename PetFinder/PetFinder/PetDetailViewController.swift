//
//  PetDetailViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/6/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit

class PetDetailViewController: UIViewController {
    
    @IBOutlet weak var petObservations: UITextView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    var detailItem: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pet Detail"
        
        if let pet = detailItem as? Dictionary<String,AnyObject> {
            petName.text = pet["name"]  as? String
            petObservations.text = pet["observations"] as? String
            
            let normalText = idLabel.text!
            let idNum = pet["id"]! as! NSNumber
            let idStr = " \(idNum)"
            let boldText  = idStr
            
            let attributedString = NSMutableAttributedString(string:normalText)
            
            let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(20)]
            let boldString = NSMutableAttributedString(string:boldText, attributes:attrs)
            
            attributedString.appendAttributedString(boldString)
            idLabel.attributedText = attributedString
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

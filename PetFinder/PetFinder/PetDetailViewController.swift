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
    var detailItem: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pet Detail"
        let borderColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        petObservations.layer.borderColor = borderColor.CGColor;
        petObservations.layer.borderWidth = 1.0;
        petObservations.layer.cornerRadius = 5.0;
        
        if let pet = detailItem as? Dictionary<String,AnyObject> {
            petName.text = pet["name"]  as? String
            petObservations.text = pet["observations"] as? String
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
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

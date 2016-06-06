//
//  MenuTableViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/29/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {
    static let emailKey = DefaultsKey<String>("email")
    static let userAuthenticated = DefaultsKey<Bool>("authenticated")
}


class MenuTableViewController: UITableViewController {

    let menuItems = ["Home", "Register Your Pet", "Registered Pets", "Reports of your Pets", "Report Pet Found", "About Us"]
    
    @IBOutlet weak var loginButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = "Pet Finder"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
        
        if Defaults.hasKey(.userAuthenticated) {
            self.navigationItem.rightBarButtonItem?.title = "Log Out"
            self.navigationItem.title = Defaults[.emailKey]
        }else{
            self.navigationItem.rightBarButtonItem?.title = "Log In/Sign Up"
            self.navigationItem.title = ""
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1{
            return menuItems.count
        }
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell
        if indexPath.section == 0{
            cell = self.tableView.dequeueReusableCellWithIdentifier("staticCell")! as UITableViewCell
            
        }else{
            cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            
            cell.textLabel?.text = menuItems[indexPath.row]
        }
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1{
            if indexPath.row == 0 {
                self.performSegueWithIdentifier("homeSegue", sender: self)
            } else if indexPath.row == 1 {
                self.performSegueWithIdentifier("registrationSegue", sender: self)
            } else if indexPath.row == 2{
                self.performSegueWithIdentifier("registeredPetSegue", sender: self)
            } else if indexPath.row == 3{
                self.performSegueWithIdentifier("retportsSegue", sender: self)
            } else if indexPath.row == 4{
                self.performSegueWithIdentifier("reportSegue", sender: self)
            } else if indexPath.row == 5{
                self.performSegueWithIdentifier("aboutSegue", sender: self)
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.section == 0{
            return 160.0
        }
        return 55.0
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        if indexPath.section == 0{
            return false
        }
        return true
    }

    @IBAction func loginButtonPressed(sender: AnyObject) {
        if Defaults.hasKey(.userAuthenticated) {
            if Defaults[.userAuthenticated] {
                Defaults.remove(.userAuthenticated)
                Defaults.remove(.emailKey)
                self.navigationItem.rightBarButtonItem?.title = "Log In/Sign Up"
                self.navigationItem.title = ""
            }else{
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewControllerWithIdentifier("loginVC")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("loginVC")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

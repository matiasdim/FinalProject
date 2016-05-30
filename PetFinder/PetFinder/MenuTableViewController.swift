//
//  MenuTableViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/29/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    let menuItems = ["Home", "Register Your Pet", "Registered Pet", "Reports of your Pets", "Report Pet Found", "About Us"]
    
    @IBOutlet weak var loginButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = "Pet Finder"
        
        let defaults = NSUserDefaults.standardUserDefaults()

        if defaults.objectForKey("loginStatus") != nil{
            self.navigationItem.rightBarButtonItem?.title = "Log Out"
        }else{
            self.navigationItem.rightBarButtonItem?.title = "Log In/Sign Up"
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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewControllerWithIdentifier("loginVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

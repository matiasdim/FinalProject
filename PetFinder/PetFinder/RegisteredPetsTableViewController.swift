//
//  RegisteredPetsTableViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import RappleProgressHUD

class RegisteredPetsTableViewController: UITableViewController {

    var pets = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if !Defaults.hasKey(.userAuthenticated) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("loginVC")
            self.navigationController?.pushViewController(vc, animated: false)
        }
        self.navigationItem.title = "Your Pets"
      }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        let pet = Pet()
        pet.email = Defaults[.emailKey]
        RappleActivityIndicatorView.startAnimatingWithLabel("Getting your pets...", attributes: RappleAppleAttributes)
        pet.list(
            { (response) in
                // retrieve the individual videos from the JSON document.
                if let topLevelObj = response as? Array<AnyObject> {
                    for i in topLevelObj {
                        self.pets.append(i)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    RappleActivityIndicatorView.stopAnimating()
                    self.tableView.reloadData()
                })
            }) { (error) in
                dispatch_async(dispatch_get_main_queue(),{
                    RappleActivityIndicatorView.stopAnimating()
                    let alert = UIAlertController(title: "Alert!", message: "There was an error fetching your pets", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                        self.navigationController?.popToRootViewControllerAnimated(false)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
                
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pets.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("petCell", forIndexPath: indexPath)

        //        cell.textLabel!.text = object.description
        if let object = pets[indexPath.row] as? Dictionary<String, AnyObject> {
                
                // setup text.
                cell.textLabel!.text = object["name"]! as? String
                cell.detailTextLabel?.text = object["observations"]! as? String
        }

        return cell
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

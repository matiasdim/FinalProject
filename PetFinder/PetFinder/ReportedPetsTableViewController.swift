//
//  ReportedPetsTableViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/30/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import RappleProgressHUD
import SCLAlertView

class ReportedPetsTableViewController: UITableViewController {

    var reports = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Reports"
        self.tableView!.separatorColor = UIColor.blackColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        if !Defaults.hasKey(.userAuthenticated) {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("loginVC")
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            if NetworkManager.isInternetReachable(){
                RappleActivityIndicatorView.startAnimatingWithLabel("Getting Reports...", attributes: RappleAppleAttributes)
                let report = Report()
                report.petOwnerEmail = Defaults[.emailKey]
                report.list(
                    { (response) in
                        if let topLevelObj = response as? Array<AnyObject> {
                            self.reports.removeAll()
                            for i in topLevelObj {
                                self.reports.append(i)
                            }
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            RappleActivityIndicatorView.stopAnimating()
                            self.tableView.reloadData()
                        })
                        
                    }, failCallback:
                    { (error) in
                        dispatch_async(dispatch_get_main_queue(),{
                            RappleActivityIndicatorView.stopAnimating()
                            let appearance = SCLAlertView.SCLAppearance(
                                showCloseButton: false
                            )
                            let alertView = SCLAlertView(appearance: appearance)
                            alertView.addButton("OK") {
                                self.navigationController?.popToRootViewControllerAnimated(false)
                            }
                            alertView.showError("Error", subTitle: "There was an error fetching the reports.")
                            
//                            let alert = UIAlertController(title: "Alert!", message: "There was an error fetching the reports", preferredStyle: UIAlertControllerStyle.Alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
//                                self.navigationController?.popToRootViewControllerAnimated(false)
//                            }))
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reports.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reportCell", forIndexPath: indexPath)
        
        //        cell.textLabel!.text = object.description
        if let object = reports[indexPath.row] as? Dictionary<String, AnyObject> {
            
            // setup text.
            if let pet = object["pet"] as? Dictionary<String, AnyObject> {
                cell.textLabel!.text = "Report about: " + (pet["name"]! as! String)
            }
            cell.detailTextLabel?.text = "Reporter: \(object["reporterName"]! as! String) - \(object["reporterEmail"]! as! String)"
            cell.accessoryView = UIImageView(image: UIImage(named:"Footprint"))
            cell.accessoryView?.frame = CGRectMake(0, 0, 15, 15)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "reportDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let report = reports[indexPath.row] as! Dictionary<String,AnyObject>
                let controller = segue.destinationViewController as! ReportDetailViewController
                controller.detailItem = report
            }
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 70.0
    }

}

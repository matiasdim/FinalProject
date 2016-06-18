//
//  MenuTableViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 5/29/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import SCLAlertView

// MARK: - Extensions
extension DefaultsKeys {
    static let emailKey = DefaultsKey<String>("email")
    static let nameKey = DefaultsKey<String>("name")
    static let userAuthenticated = DefaultsKey<Bool>("authenticated")
    static let reportsNumberKey = DefaultsKey<Int>("reportsNum")
}

extension UITextField {
    func setPreferences() {
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2
    }
}
extension UITextView {
    func setPreferences() {
        self.layer.cornerRadius = 15
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2
    }
}
extension UIButton{
    func setPreferences(){
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    }
}

class MenuTableViewController: UITableViewController {

    let menuItems = ["How It Works", "Register Your Pet", "Registered Pets", "Reports of your Pets", "Report Pet Found", "About Us"]
    var timer = NSTimer()
    
    @IBOutlet weak var loginButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.navigationController!.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        let image = UIImage(named: "BarImage")
        let imageView = UIImageView(frame: CGRectMake(0, 0, 34, 34))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        self.performSelector(#selector(veryfyNotifPermission), withObject: nil, afterDelay: 10)
        
        self.tableView!.separatorColor = UIColor.blackColor()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait]
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        
        // 4. Only allow Landscape
        return UIInterfaceOrientation.Portrait
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.shouldRotate = false
        
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        
        self.navigationController?.navigationBar.hidden = false
        self.navigationItem.rightBarButtonItem?.title = ""
        if Defaults.hasKey(.userAuthenticated) {
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "logout")
            startTimer()
        }else{
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "login")
        }

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appdelegate.shouldRotate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell
        cell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell

        cell.textLabel?.text = menuItems[indexPath.row]
        cell.accessoryView = UIImageView(image: UIImage(named:"Footprint"))
        cell.accessoryView?.frame = CGRectMake(0, 0, 15, 15)
        cell.textLabel?.font = UIFont(name:"Arial Rounded MT Bold", size: 17.0)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 55.0
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }

    // MARK: - Button Actions
    @IBAction func loginButtonPressed(sender: AnyObject) {
        if Defaults.hasKey(.userAuthenticated) {
            if Defaults[.userAuthenticated] {
                Defaults.remove(.userAuthenticated)
                Defaults.remove(.emailKey)
                Defaults.remove(.nameKey)
                Defaults.remove(.reportsNumberKey)
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "login")
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
    
    // MARK: - Other functions
    func getReports()
    {
        if Defaults.hasKey(.userAuthenticated) {
            if NetworkManager.isInternetReachable(){
                let report = Report()
                report.petOwnerEmail = Defaults[.emailKey]
                report.list(
                    { (reports) in
                        if reports.count > Defaults[.reportsNumberKey]{
                            if self.timer.valid{
                                self.timer.invalidate()
                            }
                            // Build notificacion but before it update current reports number
                            let user = User(email: Defaults[.emailKey])
                            user?.reportsNum = String(reports.count)
                            user?.updateReportsNum(
                                { (response) in
                                    dispatch_async(dispatch_get_main_queue(),{[unowned self] in
                                        self.createNotification(reports.count)
                                        Defaults[.reportsNumberKey] = reports.count
                                        if self.timer.valid{
                                            self.startTimer()
                                        }
                                        })
                                }, failCallback: { (error) in
                                    dispatch_async(dispatch_get_main_queue(),{[unowned self] in
                                        self.createNotification(reports.count)
                                        if self.timer.valid{
                                            self.startTimer()
                                        }
                                        })
                            })
                        }
                }) { (error) in
                    return
                }
            }
        }
    }
    
    func startTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(MenuTableViewController.getReports), userInfo: nil, repeats: true)
    }
    
    func createNotification(currentReports: Int) {
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 3)
        notification.alertBody = "You have \(currentReports - Defaults[.reportsNumberKey]) new report(s) of your pets"
        notification.alertAction = "to open app and see."
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["reports": ""]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func veryfyNotifPermission()
    {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        if settings!.types == .None {
            
            SCLAlertView().showWarning("Can't notify", subTitle: "We don't have permission to show you notifications, Please turn on permission on your device settings.")
        }
    }

}

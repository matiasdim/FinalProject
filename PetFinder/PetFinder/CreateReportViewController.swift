//
//  CreateReportViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/8/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import RappleProgressHUD
import CoreLocation
import SCLAlertView

class CreateReportViewController: UIViewController, CLLocationManagerDelegate {
    
    // String read on qr will be the  Id assigned to the pet on the app
    var qrString: String!
    var myLocation:CLLocationCoordinate2D? = CLLocationCoordinate2D()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var petOwnerName: UILabel!
    @IBOutlet weak var petOwnerPhone: UIButton!
    @IBOutlet weak var petOwnerEmail: UIButton!
    
    @IBOutlet weak var reporterName: UITextField!
    @IBOutlet weak var reporterMobile: UITextField!
    @IBOutlet weak var reporterEmail: UITextField!
    @IBOutlet weak var observationsText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myTextFields = [UITextField]()
        
        myTextFields = [reporterName, reporterMobile, reporterEmail]
        for item in myTextFields {
            item.setPreferences()
        }
        observationsText.setPreferences()
        
        self.navigationItem.title = "Report"
        
//        let borderColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
//        observationsText.layer.borderColor = borderColor.CGColor;
//        observationsText.layer.borderWidth = 0.5;
//        observationsText.layer.cornerRadius = 5.0;
//        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 10
        
        
        let reportButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(CreateReportViewController.reportPressed))
        self.navigationItem.rightBarButtonItem = reportButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(CreateReportViewController.cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let pet = Pet()
        if (qrString.isEmpty) {
            let appearance = SCLAlertView.SCLAppearance(
                showCloseButton: false
            )
            let alertView = SCLAlertView(appearance: appearance)
            alertView.addButton("OK") {
                self.navigationController?.popToRootViewControllerAnimated(false)
            }
            alertView.showError("Error", subTitle: "There was an error reading code. Please scan again!")
            
//            let alert = UIAlertController(title: "Alert", message: "There was an error reading code. Please scan again!", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
//                self.navigationController?.popToRootViewControllerAnimated(false)
//            }))
//            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        if NetworkManager.isInternetReachable(){
            RappleActivityIndicatorView.startAnimatingWithLabel("Getting info...", attributes: RappleAppleAttributes)
            pet.detail(qrString, successCallback:
                { (response) in
                    RappleActivityIndicatorView.stopAnimating()
                    if let pet = response as? Dictionary<String, AnyObject>{
                        if let user = pet["user"] as? Dictionary <String, AnyObject>{
                            self.petOwnerName.text = user["name"] as? String
                            self.petOwnerEmail.setTitle((user["email"] as? String), forState: UIControlState.Normal)
                            self.petOwnerPhone.setTitle((user["mobile"] as? String), forState: UIControlState.Normal)
                            
                            //Location setup (to get coordinates)
                            // Core Location Manager asks for GPS location
                            self.locationManager.delegate = self
                            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                            self.locationManager.requestWhenInUseAuthorization()
                            self.locationManager.startMonitoringSignificantLocationChanges()
                        }
                    }
            }) { (error) in
                dispatch_async(dispatch_get_main_queue(),{
                    RappleActivityIndicatorView.stopAnimating()
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false
                    )
                    let alertView = SCLAlertView(appearance: appearance)
                    alertView.addButton("OK") {
                        self.navigationController?.popToRootViewControllerAnimated(false)
                    }
                    alertView.showWarning("Error", subTitle: "There was an error getting pet owner info or may be pet is not registered.")
                    
//                    let alert = UIAlertController(title: "Alert", message: "There was an error getting pet owner info or may be pet is not registered. Please scan again!", preferredStyle: UIAlertControllerStyle.Alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
//                        self.navigationController?.popToRootViewControllerAnimated(false)
//                    }))
//                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }
        }else{
            SCLAlertView().showWarning("Alert", subTitle: "There isn't internet connection. Please connect to internet and try again.")
//            let ac = UIAlertController(title: "Alert", message: "There isn't internet connection. Please connect to internet and try again.", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func reportPressed()
    {
        self.view.endEditing(true)
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Denied || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.Restricted
        {
            SCLAlertView().showWarning("Alert", subTitle: "To send the report with your current location, you need to turn on location permission on device settings. Go to your app settings > PetFinder > Location and set it to When in use.")

//            let alert = UIAlertController(title: "Alert", message: "Yo need to turn on location permission on device settings", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            if (reporterName.text?.isEmpty)!{
                SCLAlertView().showError("Error", subTitle: "You must provide your name to create a report.")

//                let alert = UIAlertController(title: "Alert", message: "You must provide your name to create a report.", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
            }else if !((reporterMobile.text?.isEmpty)!) || !((reporterEmail.text?.isEmpty)!) || !((observationsText.text?.isEmpty)!) {
                let report = Report()
                report.reporterName = reporterName.text!
                report.reporterCel = reporterMobile.text!
                report.reporterEmail = reporterEmail.text!
                report.reporterObservations = observationsText.text!
                report.petId = qrString
                report.lat = "\(myLocation!.latitude)"
                report.lon = "\(myLocation!.longitude)"
                if (report.lat?.isEmpty)! || (report.lon?.isEmpty)! || (report.lat == "0.0" && report.lon == "0.0") {
                    SCLAlertView().showError("Error", subTitle: "Something went wrong getting your localization. Please try again.")

//                    let alert = UIAlertController(title: "Alert", message: "Something went wrong getting your localization. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil ))
//                    self.presentViewController(alert, animated: true, completion: nil)
                }else{
                    if !report.reporterEmail!.isEmpty {
                        if report.isValidEmail(){
                            createReport(report)
                        }else{
                            SCLAlertView().showError("Error", subTitle: "Please enter a valid email to continue.")

//                            let alert = UIAlertController(title: "Alert", message: "Please enter a valid email to continue.", preferredStyle: UIAlertControllerStyle.Alert)
//                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil ))
//                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                    }else{
                        createReport(report)
                    }
                }
            }else{
                SCLAlertView().showError("Error", subTitle: "You must provide at least one of the following data: \n Mobile number. \n Email. \n Observations.")

//                let alert = UIAlertController(title: "Alert", message: "You must provide at least one of the following data: \n Mobile number \n Email \n Observations", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    func createReport(report: Report)
    {
        if NetworkManager.isInternetReachable(){
            RappleActivityIndicatorView.startAnimatingWithLabel("Creating Report", attributes: RappleAppleAttributes)
            report.create(
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
                        alertView.showSuccess("Success", subTitle: "Report successfully created.")
//                        let alert = UIAlertController(title: "Alert", message: "Report successfully created.", preferredStyle: UIAlertControllerStyle.Alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
//                            self.navigationController?.popToRootViewControllerAnimated(false)
//                        }))
//                        self.presentViewController(alert, animated: true, completion: nil)
                    })
            }) { (error) in
                dispatch_async(dispatch_get_main_queue(),{
                    RappleActivityIndicatorView.stopAnimating()
                    SCLAlertView().showError("Error", subTitle: "There was an error creating report. Please scan again or call pet owner!")

//                    let alert = UIAlertController(title: "Alert", message: "There was an error creating report. Please scan again or call pet owner!", preferredStyle: UIAlertControllerStyle.Alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
//                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }
        }else{
            SCLAlertView().showWarning("Alert", subTitle: "There isn't internet connection. Please connect to internet and try again.")

//            let ac = UIAlertController(title: "Alert", message: "There isn't internet connection. Please connect to internet and try again.", preferredStyle: .Alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func cancelPressed()
    {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func phonePressed(sender: AnyObject) {
        if let url = NSURL(string: "tel://\(self.petOwnerPhone)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func emailPressed(sender: AnyObject) {
        if let url = NSURL(string: "mailto://\(self.petOwnerEmail)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        myLocation = locValue
    }
    
}
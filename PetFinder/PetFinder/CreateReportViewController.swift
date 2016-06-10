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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let borderColor = UIColor(colorLiteralRed: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        observationsText.layer.borderColor = borderColor.CGColor;
        observationsText.layer.borderWidth = 0.5;
        observationsText.layer.cornerRadius = 5.0;
        
        
        let reportButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(CreateReportViewController.reportPressed))
        self.navigationItem.rightBarButtonItem = reportButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(CreateReportViewController.cancelPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let pet = Pet()
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
                    let alert = UIAlertController(title: "Alert", message: "There was an error getting pet owner info. Please scan again!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                        self.navigationController?.popToRootViewControllerAnimated(false)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
        }
    }
    
    func reportPressed()
    {
        let report = Report()
        report.reporterName = reporterName.text!
        report.reporterCel = reporterMobile.text!
        report.reporterEmail = reporterEmail.text!
        report.reporterObservations = observationsText.text!
        report.petId = qrString
        report.lat = "\(myLocation!.latitude)"
        report.lon = "\(myLocation!.longitude)"
        
        RappleActivityIndicatorView.startAnimatingWithLabel("Creating Report", attributes: RappleAppleAttributes)
        report.create(
            { (response) in
                dispatch_async(dispatch_get_main_queue(),{
                    RappleActivityIndicatorView.stopAnimating()
                    let alert = UIAlertController(title: "Alert", message: "Report successfully created.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                        self.navigationController?.popToRootViewControllerAnimated(false)
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
            }) { (error) in
                dispatch_async(dispatch_get_main_queue(),{
                    RappleActivityIndicatorView.stopAnimating()
                    let alert = UIAlertController(title: "Alert", message: "There was an error creating report. Please scan again or call pet owner!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        myLocation = locValue
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

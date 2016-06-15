//
//  ReportDetailViewController.swift
//  PetFinder
//
//  Created by Matías  Gil Echavarría on 6/6/16.
//  Copyright © 2016 Matías Gil Echavarría. All rights reserved.
//

import UIKit
import MapKit

class ReportDetailViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var repoterName: UILabel!
    @IBOutlet weak var observationsArea: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mobileButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    var detailItem: AnyObject?
    
    var mobile: String!
    var phone: String!
    var currentPetName: String!
    var email: String!
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Report"
        
        if let report = detailItem as? Dictionary<String,AnyObject> {
            if let pet = report["pet"] as? Dictionary<String, AnyObject>{
                currentPetName = (pet["name"] as? String)
                petName.text = currentPetName
            }
            observationsArea.text = (report["reporterObservations"] as? String)
            mobile = (report["reporterCel"] as? String)
            mobileButton.setTitle(mobile, forState: UIControlState.Normal)
            phone = (report["reporterPhone"] as? String)
            phoneButton.setTitle(phone, forState: UIControlState.Normal)
            repoterName.text = (report["reporterName"] as? String)
            email = (report["reporterEmail"] as? String)
            emailButton.setTitle(email, forState: UIControlState.Normal)
            
            latitude = CLLocationDegrees((report["lat"] as? String)!)
            longitude = CLLocationDegrees((report["lon"] as? String)!)
            configMap(CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!), title: currentPetName, subtitle: "Is here!")
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMaps))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
        //Small and not nice hack to always load textarea on its top scroll
        dispatch_async(dispatch_get_main_queue(), {
            self.observationsArea.scrollRangeToVisible(NSMakeRange(0, 0))
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configMap(coordinate: CLLocationCoordinate2D, title: String, subtitle: String)
    {
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        let location:CLLocationCoordinate2D = coordinate
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
        
        mapView.setRegion(theRegion, animated: true)
        
        let anotation = MKPointAnnotation()
        anotation.coordinate = coordinate
        anotation.title = title
        anotation.subtitle = subtitle
        mapView.addAnnotation(anotation)
    }
    
    func openMaps()
    {
        if latitude != nil && longitude != nil {

            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "\(currentPetName)"
            mapItem.openInMapsWithLaunchOptions(options)
        }
    }

    @IBAction func phonePressed(sender: AnyObject) {
        if let url = NSURL(string: "tel://\(phone)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    @IBAction func mobilePressed(sender: AnyObject) {
        if let url = NSURL(string: "tel://\(mobile)") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func emailPressed(sender: AnyObject) {
        if let url = NSURL(string: "mailto:\(email)"){
            UIApplication.sharedApplication().openURL(url)
        }
    }

    
}

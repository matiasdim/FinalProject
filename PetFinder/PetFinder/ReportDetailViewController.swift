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

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var observationsArea: UITextView!
    var detailItem: AnyObject?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Report"
        
        configMap(CLLocationCoordinate2D(latitude: 42.9634, longitude: -85.6681), title: "Pet name", subtitle: "Your pet is here")
        
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  BusinessDetailViewController.swift
//  Yelp
//
//  Created by Zekun Wang on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BusinessDetailViewController: UIViewController, MKMapViewDelegate {
    
    let businessCell = "BusinessCell"
    
    @IBOutlet var businessView: UIView!
    @IBOutlet var mapView: MKMapView!
    
    var business: Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UINib(nibName: self.businessCell, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        view.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:0.8)
        view.frame = CGRect(x: 0, y: 0, width: 359, height: 120)
        let cell = view as! BusinessCell
        cell.business = self.business
        
        businessView.addSubview(view)
        businessView.layer.cornerRadius = 10
        businessView.layer.masksToBounds = true

        mapView.delegate = self
        
        if business.coordinate.count == 2 {
            let centerLocation = CLLocationCoordinate2D(latitude: business.coordinate[0], longitude: business.coordinate[1])
            addAnnotationAtCoordinate(coordinate: centerLocation, business: business)
            goToLocation(location: centerLocation)
        }
    }
    
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, business: Business) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = business.name
        self.mapView.addAnnotation(annotation)
    }
    
    func goToLocation(location: CLLocationCoordinate2D) {
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegionMake(location, span)
        self.mapView.setRegion(region, animated: false)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pin"
        // custom pin annotation
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        else {
            annotationView!.annotation = annotation
        }
        if #available(iOS 9.0, *) {
            annotationView!.pinTintColor = UIColor.red
        } else {
            // Fallback on earlier versions
        }
        annotationView!.animatesDrop = true
        
        return annotationView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

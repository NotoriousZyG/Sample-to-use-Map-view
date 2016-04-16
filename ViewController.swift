//
//  ViewController.swift
//  ParajuliHomePhaseII
//
//  Created by Notorious MAC on 1/12/16.
//  Copyright © 2016 NotoriousMAC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate {
    

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pinLocationParsa: CLLocationCoordinate2D = CLLocationCoordinate2DMake(27.612214, 84.572968)
        let pinLocationKtm: CLLocationCoordinate2D = CLLocationCoordinate2DMake(27.657327, 85.319382)
        
        let objAnnParsa = MKPointAnnotation()
        let objAnnKtm = MKPointAnnotation()
        
        objAnnParsa.coordinate = pinLocationParsa
        objAnnKtm.coordinate = pinLocationKtm
        
        objAnnKtm.title = "Parajuli Home Talchhikhel"
        objAnnKtm.subtitle = "Talchhikhel -14 Lalitpur"
        self.mapView.addAnnotation(objAnnKtm)
        
        
        objAnnParsa.title = "Parajuli Home Parsa"
        objAnnParsa.subtitle = "Khairahani - 8 Chitwan"
        self.mapView.addAnnotation(objAnnParsa)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mapType(sender: AnyObject) {
        if (segmentControl.selectedSegmentIndex == 0 ){
            mapView.mapType = MKMapType.Standard
        }
        if (segmentControl.selectedSegmentIndex == 1 ){
            mapView.mapType = MKMapType.Satellite
        }
        if (segmentControl.selectedSegmentIndex == 2 ){
            mapView.mapType = MKMapType.Hybrid
        }

    }
    
    
    
    
    @IBAction func directions(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/maps?daddr=27.612214,84.572968")!)
    }
    
    
    @IBAction func locate(sender: AnyObject) {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            manager.requestWhenInUseAuthorization()
        } else {
            // Fallback on earlier versions
        }
        manager.startUpdatingLocation()
        mapView.showsUserLocation = true
        
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        let span =  MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
    }

    
    
    
    

}


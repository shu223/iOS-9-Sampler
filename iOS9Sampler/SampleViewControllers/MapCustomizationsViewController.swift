//
//  MapCustomizationsViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 8/26/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import MapKit


class MapCustomizationsViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var compassBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

        let berlinRegion = MKCoordinateRegionMake(
            CLLocationCoordinate2DMake(52.5325233701713, 13.4107786547116),
            MKCoordinateSpanMake(0.176615416273734, 0.153035815736018))
        mapView.setRegion(berlinRegion, animated: true)

        self.setupMapCamera()
        self.updateCompassBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupMapCamera() {
        
        mapView.camera.altitude = 14000
        mapView.camera.pitch = 50
        mapView.camera.heading = 180
    }

    private func updateCompassBtn() {
        
        // shown
        if mapView.showsCompass == true {
            compassBtn.setTitle("Hide Compass", forState: UIControlState.Normal)
        }
        // hidden
        else {
            compassBtn.setTitle("Show Compass", forState: UIControlState.Normal)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // =========================================================================
    // MARK: - MKMapViewDelegate
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        print(__FUNCTION__+"\n")
    }
    
    
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func trafficBtnTapped(sender: UIButton) {

        mapView.showsTraffic = !mapView.showsTraffic

        // shown
        if mapView.showsTraffic == true {
            sender.setTitle("Hide Traffic", forState: UIControlState.Normal)
        }
        // hidden
        else {
            sender.setTitle("Show Traffic", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func scaleBtnTapped(sender: UIButton) {

        mapView.showsScale = !mapView.showsScale

        // shown
        if mapView.showsScale == true {
            sender.setTitle("Hide Scale", forState: UIControlState.Normal)
        }
        // hidden
        else {
            sender.setTitle("Show Scale", forState: UIControlState.Normal)
        }
    }

    @IBAction func compassBtnTapped(sender: UIButton) {
        
        mapView.showsCompass = !mapView.showsCompass
        
        self.updateCompassBtn()
    }

    @IBAction func flyoverBtnTapped(sender: UIButton) {
        
        // shown
        if mapView.showsCompass == true {
            sender.setTitle("Hide Compass", forState: UIControlState.Normal)
        }
            // hidden
        else {
            sender.setTitle("Show Compass", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            mapView.mapType = MKMapType.SatelliteFlyover
        case 2:
            mapView.mapType = MKMapType.HybridFlyover
        default:
            mapView.mapType = MKMapType.Standard
        }
        
        self.setupMapCamera()
    }
}

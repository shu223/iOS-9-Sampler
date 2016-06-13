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
    
    @IBOutlet weak private var mapView: MKMapView!
    @IBOutlet weak private var compassBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

        let berlinRegion = MKCoordinateRegionMake(
            CLLocationCoordinate2DMake(52.5325233701713, 13.4107786547116),
            MKCoordinateSpanMake(0.176615416273734, 0.153035815736018))
        mapView.setRegion(berlinRegion, animated: true)

        setupMapCamera()
        updateCompassBtn()
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
        if mapView.showsCompass {
            compassBtn.setTitle("Hide Compass", forState: UIControlState.Normal)
        }
        // hidden
        else {
            compassBtn.setTitle("Show Compass", forState: UIControlState.Normal)
        }
    }
    
    // =========================================================================
    // MARK: - MKMapViewDelegate
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        print(__FUNCTION__+"\n")
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func trafficBtnTapped(sender: UIButton) {

        mapView.showsTraffic = !mapView.showsTraffic

        if mapView.showsTraffic {
            sender.setTitle("Hide Traffic", forState: UIControlState.Normal)
        } else {
            sender.setTitle("Show Traffic", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func scaleBtnTapped(sender: UIButton) {

        mapView.showsScale = !mapView.showsScale

        if mapView.showsScale {
            sender.setTitle("Hide Scale", forState: UIControlState.Normal)
        } else {
            sender.setTitle("Show Scale", forState: UIControlState.Normal)
        }
    }

    @IBAction func compassBtnTapped(sender: UIButton) {
        
        mapView.showsCompass = !mapView.showsCompass
        
        updateCompassBtn()
    }

    @IBAction func flyoverBtnTapped(sender: UIButton) {
        
        if mapView.showsCompass {
            sender.setTitle("Hide Compass", forState: UIControlState.Normal)
        } else {
            sender.setTitle("Show Compass", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            mapView.mapType = .SatelliteFlyover
        case 2:
            mapView.mapType = .HybridFlyover
        default:
            mapView.mapType = .Standard
        }
        
        setupMapCamera()
    }
}

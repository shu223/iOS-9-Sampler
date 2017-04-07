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
    
    @IBOutlet weak fileprivate var mapView: MKMapView!
    @IBOutlet weak fileprivate var compassBtn: UIButton!
    
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
    
    fileprivate func setupMapCamera() {
        
        mapView.camera.altitude = 14000
        mapView.camera.pitch = 50
        mapView.camera.heading = 180
    }

    fileprivate func updateCompassBtn() {
        // shown
        if mapView.showsCompass {
            compassBtn.setTitle("Hide Compass", for: UIControlState())
        }
        // hidden
        else {
            compassBtn.setTitle("Show Compass", for: UIControlState())
        }
    }
    
    // =========================================================================
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        print(__FUNCTION__+"\n")
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func trafficBtnTapped(_ sender: UIButton) {

        mapView.showsTraffic = !mapView.showsTraffic

        if mapView.showsTraffic {
            sender.setTitle("Hide Traffic", for: UIControlState())
        } else {
            sender.setTitle("Show Traffic", for: UIControlState())
        }
    }
    
    @IBAction func scaleBtnTapped(_ sender: UIButton) {

        mapView.showsScale = !mapView.showsScale

        if mapView.showsScale {
            sender.setTitle("Hide Scale", for: UIControlState())
        } else {
            sender.setTitle("Show Scale", for: UIControlState())
        }
    }

    @IBAction func compassBtnTapped(_ sender: UIButton) {
        
        mapView.showsCompass = !mapView.showsCompass
        
        updateCompassBtn()
    }

    @IBAction func flyoverBtnTapped(_ sender: UIButton) {
        
        if mapView.showsCompass {
            sender.setTitle("Hide Compass", for: UIControlState())
        } else {
            sender.setTitle("Show Compass", for: UIControlState())
        }
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            mapView.mapType = .satelliteFlyover
        case 2:
            mapView.mapType = .hybridFlyover
        default:
            mapView.mapType = .standard
        }
        
        setupMapCamera()
    }
}

//
//  ForceTouchViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/17/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class ForceTouchViewController: UIViewController {

    fileprivate let kMaxRadius: CGFloat = 100.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if traitCollection.forceTouchCapability != UIForceTouchCapability.available {
            let alert = UIAlertController(
                title: "Unavailable",
                message: "Force touch is not available on this device.",
                preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertAction.Style.cancel,
                handler: { [unowned self] (action) -> Void in
                    self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion:nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // =========================================================================
    // MARK: Private
    
    fileprivate func createHaloAt(_ location: CGPoint, withRadius radius: CGFloat) {
        
        let halo = PulsingHaloLayer()
        halo.repeatCount = 1
        halo.position = location
        halo.radius = radius * 2.0
        halo.fromValueForRadius = 0.5
        halo.keyTimeForHalfOpacity = 0.7
        halo.animationDuration = 0.8
        view.layer.addSublayer(halo)
        halo.start()
    }
    
    fileprivate func showTouches(_ touches: Set<UITouch>) {
        for touch in touches {
            let location = touch.location(in: view)
            let radius = kMaxRadius * touch.force / touch.maximumPossibleForce
            createHaloAt(location, withRadius: radius)
        }
    }
    
    // =========================================================================
    // MARK: Touch Handlers

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        showTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        showTouches(touches)
    }
}

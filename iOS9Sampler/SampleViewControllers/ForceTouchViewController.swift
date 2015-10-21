//
//  ForceTouchViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/17/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit


let kMaxRadius: CGFloat = 100.0


class ForceTouchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if traitCollection.forceTouchCapability != UIForceTouchCapability.Available {
            
            let alert = UIAlertController(
                title: "Unavailable",
                message: "Force touch is not available on this device.",
                preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Cancel,
                handler: { (action) -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
            })
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion:nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    // MARK: Private
    
    private func createHaloAt(location: CGPoint, withRadius radius: CGFloat) {
        
        let halo = PulsingHaloLayer()
        halo.repeatCount = 1
        halo.position = location
        halo.radius = radius * 2.0
        halo.fromValueForRadius = 0.5
        halo.keyTimeForHalfOpacity = 0.7
        halo.animationDuration = 0.8
        self.view.layer.addSublayer(halo)
    }
    
    private func showTouches(touches: Set<UITouch>) {
        
        for obj: AnyObject in touches {
            
            let touch = obj as! UITouch
            let location = touch.locationInView(self.view)
            
            let radius = kMaxRadius * touch.force / touch.maximumPossibleForce
            
            self.createHaloAt(location, withRadius: radius)
        }
    }
    
    
    // =========================================================================
    // MARK: Touch Handlers
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        self.showTouches(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        self.showTouches(touches)
    }
}

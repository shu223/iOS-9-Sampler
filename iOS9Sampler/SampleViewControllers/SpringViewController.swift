//
//  SpringViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/13/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//
//  Thanks to
//  http://qiita.com/kaway/items/b9e85403a4d78c11f8df


import UIKit


class SpringViewController: UIViewController {

    
    @IBOutlet weak private var massSlider: UISlider!
    @IBOutlet weak private var massLabel: UILabel!
    @IBOutlet weak private var stiffnessSlider: UISlider!
    @IBOutlet weak private var stiffnessLabel: UILabel!
    @IBOutlet weak private var dampingSlider: UISlider!
    @IBOutlet weak private var dampingLabel: UILabel!
    @IBOutlet weak private var durationLabel: UILabel!

    @IBOutlet weak private var animateBtn: UIButton!
    @IBOutlet weak private var imageView: UIImageView!

    private let animation = CASpringAnimation(keyPath: "position")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        animation.initialVelocity = -5.0
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self


        // update labels
        massChanged(massSlider)
        stiffnessChanged(stiffnessSlider)
        dampingChanged(dampingSlider)
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let fromPos = CGPoint(x: CGRectGetMidX(view.bounds) + 100, y: imageView.center.y)
        let toPos   = CGPoint(x: fromPos.x - 200, y: fromPos.y)
        animation.fromValue = NSValue(CGPoint: fromPos)
        animation.toValue = NSValue(CGPoint: toPos)

        imageView.center = fromPos
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func updateDurationLabel() {
        durationLabel.text = String(format: "settlingDuration:%.1f", animation.settlingDuration)
    }

    
    // =========================================================================
    // MARK: - CAAnimation Delegate
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        animateBtn.enabled = true
    }
    
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func massChanged(sender: UISlider) {
        massLabel.text = String(format: "%.1f", sender.value)
        animation.mass = CGFloat(sender.value)
        updateDurationLabel()
    }

    @IBAction func stiffnessChanged(sender: UISlider) {
        stiffnessLabel.text = String(format: "%.1f", sender.value)
        animation.stiffness = CGFloat(sender.value)
        updateDurationLabel()
    }

    @IBAction func dampingChanged(sender: UISlider) {
        dampingLabel.text = String(format: "%.1f", sender.value)
        animation.damping = CGFloat(sender.value)
        updateDurationLabel()
    }

    @IBAction func animateBtnTapped(sender: UIButton) {

        animateBtn.enabled = false
        
        animation.duration = animation.settlingDuration
        imageView.layer.addAnimation(animation, forKey: nil)
    }
}

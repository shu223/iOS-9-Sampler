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

class SpringViewController: UIViewController, CAAnimationDelegate {
    
    @IBOutlet weak fileprivate var massSlider: UISlider!
    @IBOutlet weak fileprivate var massLabel: UILabel!
    @IBOutlet weak fileprivate var stiffnessSlider: UISlider!
    @IBOutlet weak fileprivate var stiffnessLabel: UILabel!
    @IBOutlet weak fileprivate var dampingSlider: UISlider!
    @IBOutlet weak fileprivate var dampingLabel: UILabel!
    @IBOutlet weak fileprivate var durationLabel: UILabel!

    @IBOutlet weak fileprivate var animateBtn: UIButton!
    @IBOutlet weak fileprivate var imageView: UIImageView!

    fileprivate let animation = CASpringAnimation(keyPath: "position")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        animation.initialVelocity = -5.0
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self

        // update labels
        massChanged(massSlider)
        stiffnessChanged(stiffnessSlider)
        dampingChanged(dampingSlider)
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let fromPos = CGPoint(x: view.bounds.midX + 100, y: imageView.center.y)
        let toPos   = CGPoint(x: fromPos.x - 200, y: fromPos.y)
        animation.fromValue = NSValue(cgPoint: fromPos)
        animation.toValue = NSValue(cgPoint: toPos)

        imageView.center = fromPos
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func updateDurationLabel() {
        durationLabel.text = String(format: "settlingDuration:%.1f", animation.settlingDuration)
    }
    
    // =========================================================================
    // MARK: - CAAnimation Delegate
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        animateBtn.isEnabled = true
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func massChanged(_ sender: UISlider) {
        massLabel.text = String(format: "%.1f", sender.value)
        animation.mass = CGFloat(sender.value)
        updateDurationLabel()
    }

    @IBAction func stiffnessChanged(_ sender: UISlider) {
        stiffnessLabel.text = String(format: "%.1f", sender.value)
        animation.stiffness = CGFloat(sender.value)
        updateDurationLabel()
    }

    @IBAction func dampingChanged(_ sender: UISlider) {
        dampingLabel.text = String(format: "%.1f", sender.value)
        animation.damping = CGFloat(sender.value)
        updateDurationLabel()
    }

    @IBAction func animateBtnTapped(_ sender: UIButton) {
        animateBtn.isEnabled = false
        animation.duration = animation.settlingDuration
        imageView.layer.add(animation, forKey: nil)
    }
}

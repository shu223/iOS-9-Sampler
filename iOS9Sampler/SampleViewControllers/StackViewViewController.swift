//
//  StackViewViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/13/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class StackViewViewController: UIViewController {
    
    @IBOutlet weak private var holizontalStackView: UIStackView!
    @IBOutlet weak private var verticalStackView: UIStackView!
    
    private var prevCnt: UInt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func imageViewWithImage(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        return imageView
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func stepperChanged(sender: UIStepper) {
        
        if UInt(sender.value) > prevCnt { // Add arranged subviews
            
            let image = UIImage(named: String(format: "m%d", Int(sender.value)))!

            holizontalStackView.insertArrangedSubview(imageViewWithImage(image), atIndex: 0)
            verticalStackView.insertArrangedSubview(imageViewWithImage(image), atIndex: 0)
            
            // animate
            UIView.animateWithDuration(0.5, animations: { [unowned self] () -> Void in
                self.holizontalStackView.layoutIfNeeded()
                self.verticalStackView.layoutIfNeeded()
            })
        } else if prevCnt >= 1 { // remove arranged subviews
            
            holizontalStackView.removeArrangedSubview(holizontalStackView.arrangedSubviews.first!)
            holizontalStackView.subviews.last?.removeFromSuperview()
            
            verticalStackView.removeArrangedSubview(verticalStackView.arrangedSubviews.first!)
            verticalStackView.subviews.last?.removeFromSuperview()
        }
        
        prevCnt = UInt(sender.value)
    }
}

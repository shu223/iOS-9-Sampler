//
//  StackViewViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/13/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class StackViewViewController: UIViewController {
    
    @IBOutlet weak fileprivate var holizontalStackView: UIStackView!
    @IBOutlet weak fileprivate var verticalStackView: UIStackView!
    
    fileprivate var prevCnt: UInt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    fileprivate func imageViewWithImage(_ image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        return imageView
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        
        if UInt(sender.value) > prevCnt { // Add arranged subviews
            
            let image = UIImage(named: String(format: "m%d", Int(sender.value)))!

            holizontalStackView.insertArrangedSubview(imageViewWithImage(image), at: 0)
            verticalStackView.insertArrangedSubview(imageViewWithImage(image), at: 0)
            
            // animate
            UIView.animate(withDuration: 0.5, animations: { [unowned self] () -> Void in
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

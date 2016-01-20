//
//  TextDetectViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class TextDetectViewController: UIViewController {

    
    @IBOutlet private var imageView1: UIImageView!
    @IBOutlet private var imageView2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


    private func rectForFeature(feature: CITextFeature, bounds: CGRect, scale: CGFloat) -> CGRect {
        
        return CGRectMake(
            feature.topLeft.x * scale,
            bounds.height - feature.topLeft.y * scale,
            feature.bounds.size.width * scale,
            feature.bounds.size.height * scale)
    }
    
    private func detect(imageView: UIImageView) {
        
        let image  = CIImage(CGImage: imageView.image!.CGImage!)

        let detector = CIDetector(
            ofType: CIDetectorTypeText,
            context: nil,
            options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        let features = detector.featuresInImage(
            image,
            options: [CIDetectorReturnSubFeatures: NSNumber(bool: true)])
        let scale = imageView.frame.size.width / image.extent.width
        
        for feature in features as! [CITextFeature] {
            print("bounds:\(feature.bounds), topLeft:\(feature.topLeft), bottomRight:\(feature.bottomRight)")
            
            // draw feature rects
            let featureRect = self.rectForFeature(feature, bounds: imageView.bounds, scale: scale)
            let featureView = UIView(frame: featureRect)
            featureView.backgroundColor = UIColor.clearColor()
            featureView.layer.borderColor = UIColor.greenColor().colorWithAlphaComponent(0.8).CGColor
            featureView.layer.borderWidth = 2.0
            imageView.addSubview(featureView)
            
            // draw subFeature rects
            for subFeature in feature.subFeatures as! [CITextFeature] {

                let subFeatureRect = self.rectForFeature(subFeature, bounds: imageView.bounds, scale: scale)
                let subFeatureView = UIView(frame: subFeatureRect)
                subFeatureView.backgroundColor = UIColor.clearColor()
                subFeatureView.layer.borderColor = UIColor.yellowColor().colorWithAlphaComponent(0.8).CGColor
                subFeatureView.layer.borderWidth = 1.0
                imageView.addSubview(subFeatureView)
            }
        }
    }
    
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func detactBtnTapped(sender: UIButton) {

        sender.hidden = true
        
        self.detect(imageView1)
        self.detect(imageView2)
    }
}

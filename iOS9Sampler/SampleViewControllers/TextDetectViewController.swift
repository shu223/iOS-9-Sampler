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
    
    private func detect(imageView: UIImageView) {
        guard let cgimage = imageView.image?.CGImage else {fatalError()}
        let image = CIImage(CGImage: cgimage)

        let detector = CIDetector(
            ofType: CIDetectorTypeText,
            context: nil,
            options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        let options = [CIDetectorReturnSubFeatures: true]
        guard let features = detector.featuresInImage(image, options: options) as? [CITextFeature] else {fatalError()}
        
        let scale = imageView.frame.size.width / image.extent.width
        for feature in features {
            print("bounds:\(feature.bounds), topLeft:\(feature.topLeft), bottomRight:\(feature.bottomRight)")
            // draw feature's rects
            feature.drawRectOnView(imageView, color: UIColor.greenColor().colorWithAlphaComponent(0.8), borderWidth: 2.0, scale: scale)
            
            // draw subFeature's rects
            guard let subFeatures = feature.subFeatures as? [CITextFeature] else {fatalError()}
            for subFeature in subFeatures {
                subFeature.drawRectOnView(imageView, color: UIColor.yellowColor().colorWithAlphaComponent(0.8), borderWidth: 1.0, scale: scale)
            }
        }
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func detactBtnTapped(sender: UIButton) {
        sender.hidden = true
        
        detect(imageView1)
        detect(imageView2)
    }
}

extension CITextFeature {
    private func rectInBounds(inBounds: CGRect, scale: CGFloat) -> CGRect {
        return CGRectMake(
            topLeft.x * scale,
            inBounds.height - topLeft.y * scale,
            bounds.size.width * scale,
            bounds.size.height * scale)
    }
    
    private func drawRectOnView(view: UIView, color: UIColor, borderWidth: CGFloat, scale: CGFloat) {
        let featureRect = rectInBounds(view.bounds, scale: scale)
        let featureView = UIView(frame: featureRect)
        featureView.backgroundColor = UIColor.clearColor()
        featureView.layer.borderColor = color.CGColor
        featureView.layer.borderWidth = borderWidth
        view.addSubview(featureView)
    }
}
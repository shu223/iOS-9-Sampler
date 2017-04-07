//
//  TextDetectViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class TextDetectViewController: UIViewController {
    
    @IBOutlet fileprivate var imageView1: UIImageView!
    @IBOutlet fileprivate var imageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func detect(_ imageView: UIImageView) {
        guard let cgimage = imageView.image?.cgImage else {fatalError()}
        let image = CIImage(cgImage: cgimage)

        let detector = CIDetector(
            ofType: CIDetectorTypeText,
            context: nil,
            options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        let options = [CIDetectorReturnSubFeatures: true]
        guard let features = detector.features(in: image, options: options) as? [CITextFeature] else {fatalError()}
        
        let scale = imageView.frame.size.width / image.extent.width
        for feature in features {
            print("bounds:\(feature.bounds), topLeft:\(feature.topLeft), bottomRight:\(feature.bottomRight)")
            // draw feature's rects
            feature.drawRectOnView(imageView, color: UIColor.green.withAlphaComponent(0.8), borderWidth: 2.0, scale: scale)
            
            // draw subFeature's rects
            guard let subFeatures = feature.subFeatures as? [CITextFeature] else {fatalError()}
            for subFeature in subFeatures {
                subFeature.drawRectOnView(imageView, color: UIColor.yellow.withAlphaComponent(0.8), borderWidth: 1.0, scale: scale)
            }
        }
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func detactBtnTapped(_ sender: UIButton) {
        sender.isHidden = true
        
        detect(imageView1)
        detect(imageView2)
    }
}

extension CITextFeature {
    fileprivate func rectInBounds(_ inBounds: CGRect, scale: CGFloat) -> CGRect {
        return CGRect(
            x: topLeft.x * scale,
            y: inBounds.height - topLeft.y * scale,
            width: bounds.size.width * scale,
            height: bounds.size.height * scale)
    }
    
    fileprivate func drawRectOnView(_ view: UIView, color: UIColor, borderWidth: CGFloat, scale: CGFloat) {
        let featureRect = rectInBounds(view.bounds, scale: scale)
        let featureView = UIView(frame: featureRect)
        featureView.backgroundColor = UIColor.clear
        featureView.layer.borderColor = color.cgColor
        featureView.layer.borderWidth = borderWidth
        view.addSubview(featureView)
    }
}

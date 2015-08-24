//
//  TextDetectViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class TextDetectViewController: UIViewController {

    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.detect(imageView1)
        self.detect(imageView2)
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
    
    private func detect(imageView: UIImageView) {
        
        let image  = CIImage(CGImage: imageView.image!.CGImage!)

        let detector = CIDetector(
            ofType: CIDetectorTypeText,
            context: nil,
            options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        
        let features = detector.featuresInImage(image)
        let scale = imageView.frame.size.width / image.extent.width
        
        for feature in features as! [CITextFeature] {
            print("bounds:\(feature.bounds), topLeft:\(feature.topLeft), bottomRight:\(feature.bottomRight)")
            
            let featureRect = CGRectMake(
                feature.topLeft.x * scale,
                imageView.bounds.height - feature.topLeft.y * scale,
                feature.bounds.size.width * scale,
                feature.bounds.size.height * scale)
            let featureView = UIView(frame: featureRect)
            featureView.backgroundColor = UIColor.clearColor()
            featureView.layer.borderColor = UIColor.greenColor().colorWithAlphaComponent(0.8).CGColor
            featureView.layer.borderWidth = 2.0
            imageView.addSubview(featureView)
        }
    }
}

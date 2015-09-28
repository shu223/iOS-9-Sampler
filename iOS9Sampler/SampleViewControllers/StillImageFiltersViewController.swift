//
//  StillImageFiltersViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit


class StillImageFiltersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var items: [String] = []
    var orgImage: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.backgroundColor = UIColor.blackColor();
        orgImage = imageView.image

        let exceptCategories = [
            kCICategoryTransition,
            kCICategoryGenerator,
            kCICategoryReduction,
        ]
        items = FilterHelper.filterNamesFor_iOS9(kCICategoryBuiltIn, exceptCategories: exceptCategories)
        items.insert("Original", atIndex: 0)
        print("num:\(items.count)\n")
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
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    
    // =========================================================================
    // MARK: - UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0 {
            imageView.image = orgImage
            return
        }
        
        indicator.startAnimating()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {

            let inputImage = CIImage(image: self.orgImage)!
            
            // Create CIFilter object
            let params = [kCIInputImageKey: inputImage]
            let filter = CIFilter(name: self.items[row], withInputParameters: params)!
            filter.setDefaults()
            
            let attributes = filter.attributes

            // for CIShadedMaterial
            if attributes["inputShadingImage"] != nil {
                filter.setValue(inputImage, forKey: "inputShadingImage")
            }
            
            // Apply filter
            let context = CIContext(options: nil)
            let outputImage = filter.outputImage
            
            if outputImage == nil {
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.imageView.image = nil
                    self.indicator.stopAnimating()
                }
            }
            else {
                
                var extent = outputImage!.extent
//                let scale = UIScreen.mainScreen().scale
                var scale: CGFloat!
                
                // some outputImage have infinite extents. e.g. CIDroste
                if extent.isInfinite == true {
                    let size = self.imageView.frame.size
                    scale = UIScreen.mainScreen().scale
                    extent = CGRectMake(0, 0, size.width * scale, size.height * scale)
                }
                else {
                    scale = extent.size.width / self.orgImage.size.width
                }
                
                let cgImage = context.createCGImage(outputImage!, fromRect: extent)
                let image = UIImage(CGImage: cgImage, scale: scale, orientation: UIImageOrientation.Up)
                print("extent:\(extent), image:\(image), org:\(self.orgImage), scale:\(scale)\n")
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.imageView.image = image
                    self.indicator.stopAnimating()
                }
            }
        }
    }
}

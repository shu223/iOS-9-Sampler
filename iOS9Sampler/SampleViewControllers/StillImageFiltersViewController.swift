//
//  StillImageFiltersViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 2015/06/19.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit

class StillImageFiltersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak fileprivate var imageView: UIImageView!
    @IBOutlet weak fileprivate var picker: UIPickerView!
    @IBOutlet weak fileprivate var indicator: UIActivityIndicatorView!
    
    fileprivate var items: [String] = []
    fileprivate var orgImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.backgroundColor = UIColor.black;
        orgImage = imageView.image

        let exceptCategories = [
            kCICategoryTransition,
            kCICategoryGenerator,
            kCICategoryReduction,
        ]
        items = Filter.names(9, category: kCICategoryBuiltIn, exceptCategories: exceptCategories)
        items.insert("Original", at: 0)
        print("num:\(items.count)\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // =========================================================================
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    // =========================================================================
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0 {
            imageView.image = orgImage
            return
        }
        
        indicator.startAnimating()
        
        DispatchQueue.global(qos: .default).async {
            
            let inputImage = CIImage(image: self.orgImage)!
            
            // Create CIFilter object
            let params = [kCIInputImageKey: inputImage]
            guard let filter = CIFilter(name: self.items[row], parameters: params) else {fatalError()}
            filter.setDefaults()
            
            let attributes = filter.attributes

            // for CIShadedMaterial
            if attributes["inputShadingImage"] != nil {
                filter.setValue(inputImage, forKey: "inputShadingImage")
            }
            
            // Apply filter
            let context = CIContext(options: nil)
            guard let outputImage = filter.outputImage else {
                DispatchQueue.main.async {
                    self.imageView.image = nil
                    self.indicator.stopAnimating()
                }
                return
            }

            var extent = outputImage.extent
            // let scale = UIScreen.mainScreen().scale
            let scale: CGFloat!
            
            // some outputImage have infinite extents. e.g. CIDroste
            if extent.isInfinite {
                let size = self.imageView.frame.size
                scale = UIScreen.main.scale
                extent = CGRect(x: 0, y: 0, width: size.width * scale, height: size.height * scale)
            } else {
                scale = extent.size.width / self.orgImage.size.width
            }
            
            guard let cgImage = context.createCGImage(outputImage, from: extent) else {fatalError()}
            let image = UIImage(cgImage: cgImage, scale: scale, orientation: UIImage.Orientation.up)
            print("extent:\(extent), image:\(image), org:\(String(describing: self.orgImage)), scale:\(String(describing: scale))\n")
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.indicator.stopAnimating()
            }
        }
    }
}

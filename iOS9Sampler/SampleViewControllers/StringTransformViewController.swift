//
//  StringTransformViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/16/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//
//  Thanks to:
//  http://nshipster.com/ios9/


import UIKit


class StringTransformViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak private var kanaLabel: UILabel!
    @IBOutlet weak private var widthSwitch: UISwitch!
    @IBOutlet weak private var transformedLabel: UILabel!
    @IBOutlet weak private var picker: UIPickerView!
    
    private var items: [String] = [
        NSStringTransformToLatin,
        NSStringTransformLatinToKatakana,
        NSStringTransformLatinToHiragana,
        NSStringTransformLatinToHangul,
        NSStringTransformLatinToArabic,
        NSStringTransformLatinToHebrew,
        NSStringTransformLatinToThai,
        NSStringTransformLatinToCyrillic,
        NSStringTransformLatinToGreek,
    ]
    
    private var orgKana = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        orgKana = kanaLabel.text!
        
        self.pickerView(picker, didSelectRow: 0, inComponent: 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

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

        let item = items[row]

        // strip the prefix
        let title: String
        let toIndex = item.rangeOfString("To")?.endIndex
        if toIndex != nil {
            // example: ")kCFStringTransformToLatin"
            title = item.substringFromIndex(toIndex!)
        }
        else {
            // example: ")kCFStringTransformLatinKatakana"
            let latinIndex = item.rangeOfString("Latin")!.endIndex
            title = item.substringFromIndex(latinIndex)
        }
        
        return title
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        transformedLabel.text = "Hello, world!".stringByApplyingTransform(items[row], reverse: false)
    }
    
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func hiraganaToKatakanaSwitchChanged(sender: UISwitch) {
        
        kanaLabel.text = kanaLabel.text!.stringByApplyingTransform(NSStringTransformHiraganaToKatakana, reverse: !sender.on)
        
        widthSwitch.enabled = sender.on
    }

    @IBAction func widthSwitchChanged(sender: UISwitch) {
        
        kanaLabel.text = kanaLabel.text!.stringByApplyingTransform(NSStringTransformFullwidthToHalfwidth, reverse: !sender.on)
    }
}

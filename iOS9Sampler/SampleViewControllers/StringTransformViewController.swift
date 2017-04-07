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
    
    @IBOutlet weak fileprivate var kanaLabel: UILabel!
    @IBOutlet weak fileprivate var widthSwitch: UISwitch!
    @IBOutlet weak fileprivate var transformedLabel: UILabel!
    @IBOutlet weak fileprivate var picker: UIPickerView!
    
    fileprivate var items: [String] = [
        StringTransform.toLatin,
        StringTransform.latinToKatakana,
        StringTransform.latinToHiragana,
        StringTransform.latinToHangul,
        StringTransform.latinToArabic,
        StringTransform.latinToHebrew,
        StringTransform.latinToThai,
        StringTransform.latinToCyrillic,
        StringTransform.latinToGreek,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView(picker, didSelectRow: 0, inComponent: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

        let item = items[row]

        // strip the prefix
        let title: String
        if let toIndex = item.range(of: "To")?.upperBound {
            // example: ")kCFStringTransformToLatin"
            title = item.substring(from: toIndex)
        }
        else {
            // example: ")kCFStringTransformLatinKatakana"
            let latinIndex = item.range(of: "Latin")!.upperBound
            title = item.substring(from: latinIndex)
        }
        
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        transformedLabel.text = "Hello, world!".stringByApplyingTransform(items[row], reverse: false)
    }
    
    // =========================================================================
    // MARK: - Actions
    
    @IBAction func hiraganaToKatakanaSwitchChanged(_ sender: UISwitch) {
        guard let orgKana = kanaLabel.text else {fatalError()}
        widthSwitch.isEnabled = sender.isOn
        
        kanaLabel.text = orgKana.stringByApplyingTransform(StringTransform.hiraganaToKatakana, reverse: !sender.isOn)
    }

    @IBAction func widthSwitchChanged(_ sender: UISwitch) {
        guard let orgKana = kanaLabel.text else {fatalError()}
        
        kanaLabel.text = orgKana.stringByApplyingTransform(StringTransform.fullwidthToHalfwidth, reverse: !sender.isOn)
    }
}

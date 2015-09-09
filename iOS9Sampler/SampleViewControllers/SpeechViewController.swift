//
//  SpeechViewController.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 9/9/15.
//  Copyright © 2015 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import AVFoundation


class SpeechViewController: UITableViewController {

    
    @IBOutlet weak var qualitySegmentedCtl: UISegmentedControl!
    
    let synthesizer = AVSpeechSynthesizer()
    var speechVoices = AVSpeechSynthesisVoice.speechVoices()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alexVoice = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
        if alexVoice != nil {
            speechVoices.insert(alexVoice!, atIndex: 0)
        }
        else {
            print("\"AVSpeechSynthesisVoiceIdentifierAlex\" couldn't be instantiated.")
        }
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
    // MARK: - UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return speechVoices.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let voice = speechVoices[indexPath.row]
        
        cell.textLabel?.text = voice.name
        
        let qualityStr = voice.quality == .Enhanced ? "Enhanced" : "Default"
        cell.detailTextLabel?.text = "lang:\(voice.language), quality:\(qualityStr)"
        
        return cell
    }
    
    
    // =========================================================================
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if synthesizer.speaking == false {
            
            let voice = speechVoices[indexPath.row]
            
            // [note]Welcome pull requests for your languages!
            let utteranceStr: String
            switch (voice.language) {
            case "ja-JP":
                utteranceStr = "私は寿司が好きです。"
            default:
                utteranceStr = "I like Sushi."
            }
            
            let utterance = AVSpeechUtterance(string: utteranceStr)
            utterance.voice = voice
            
            synthesizer.speakUtterance(utterance)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

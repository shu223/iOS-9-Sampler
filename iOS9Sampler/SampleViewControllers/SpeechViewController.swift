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
    
    @IBOutlet weak fileprivate var qualitySegmentedCtl: UISegmentedControl!
    
    fileprivate let synthesizer = AVSpeechSynthesizer()
    fileprivate var speechVoices = AVSpeechSynthesisVoice.speechVoices()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alexVoice = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
        if let alexVoice = alexVoice {
            speechVoices.insert(alexVoice, at: 0)
        } else {
            print("\"AVSpeechSynthesisVoiceIdentifierAlex\" couldn't be instantiated.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // =========================================================================
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speechVoices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let voice = speechVoices[indexPath.row]
        
        cell.textLabel?.text = voice.name
        
        let qualityStr = voice.quality == .enhanced ? "Enhanced" : "Default"
        cell.detailTextLabel?.text = "lang:\(voice.language), quality:\(qualityStr)"
        
        return cell
    }
    
    // =========================================================================
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !synthesizer.isSpeaking {
            
            let voice = speechVoices[indexPath.row]
            
            // [note]Welcome pull requests for your languages!
            let utteranceStr: String
            switch voice.language {
            case "ja-JP":
                utteranceStr = "私は寿司が好きです。"
            default:
                utteranceStr = "I like Sushi."
            }
            
            let utterance = AVSpeechUtterance(string: utteranceStr)
            utterance.voice = voice
            
            synthesizer.speak(utterance)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

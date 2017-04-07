//
//  AudioEngine.swift
//  iOS9Sampler
//
//  Created by Shuichi Tsutsumi on 6/12/16.
//  Copyright © 2016 Shuichi Tsutsumi. All rights reserved.
//

import Foundation
import AVFoundation

struct AudioEngine {
    fileprivate let engine = AVAudioEngine()
    fileprivate let player = AVAudioPlayerNode()
    fileprivate var file: AVAudioFile?

    /// The currently selected `AUAudioUnit` effect, if any.
    fileprivate var audioUnit: AUAudioUnit?
    /// The audio unit's presets.
    fileprivate var presetList = [AUAudioUnitPreset]()
    /// Engine's effect node.
    fileprivate var effect: AVAudioUnit?

    init() {
        setup()
    }
    
    fileprivate mutating func setup() {
        // setup engine and player
        engine.attach(player)
        guard let fileURL = Bundle.main.url(forResource: "drumLoop", withExtension: "caf") else {
            fatalError("\"drumLoop.caf\" file not found.")
        }
        do {
            let file = try AVAudioFile(forReading: fileURL)
            self.file = file
            engine.connect(player, to: engine.mainMixerNode, format: file.processingFormat)
        }
        catch {
            fatalError("Could not create AVAudioFile instance. error: \(error).")
        }
    }
    
    fileprivate func scheduleLoop() {
        guard let file = file else {
            fatalError("`file` must not be nil in \(#function).")
        }
        
        player.scheduleFile(file, at: nil) {
            self.scheduleLoop()
        }
    }
    
    // =========================================================================
    // MARK: - Public
    
    func start() {
        // Schedule buffers on the player.
        scheduleLoop()
        
        // Start the engine.
        do {
            try engine.start()
        }
        catch {
            fatalError("Could not start engine. error: \(error).")
        }
        player.play()
    }
    
    // Stop the engine
    func stop() {
        player.stop()
        engine.stop()        
    }

    mutating func selectEffectWithComponentDescription(_ componentDescription: AudioComponentDescription?, completionHandler: ((Void) -> Void) = {}) {
        
        // Internal function to resume playing and call the completion handler.
        func done() {
            player.play()
            completionHandler()
        }
        
        /*
         Pause the player before re-wiring it. (It is not simple to keep it
         playing across an effect insertion or deletion.)
         */
        player.pause()
        
        // Destroy any pre-existing effect.
        if let effect = effect {
            // We have player -> effect -> mixer. Break both connections.
            engine.disconnectNodeInput(effect)
            engine.disconnectNodeInput(engine.mainMixerNode)
            
            // Connect player -> mixer.
            engine.connect(player, to: engine.mainMixerNode, format: file!.processingFormat)
            
            // We're done with the effect; release all references.
            engine.detach(effect)
            
            self.effect = nil
            audioUnit = nil
            presetList = [AUAudioUnitPreset]()
        }
        
        // Insert the new effect, if any.
        if let componentDescription = componentDescription {
            AVAudioUnit.instantiate(with: componentDescription, options: []) { avAudioUnit, error in
                guard let avAudioUnitEffect = avAudioUnit else { return }
                
                self.effect = avAudioUnitEffect
                self.engine.attach(avAudioUnitEffect)
                
                // Disconnect player -> mixer.
                self.engine.disconnectNodeInput(self.engine.mainMixerNode)
                
                // Connect player -> effect -> mixer.
                self.engine.connect(self.player, to: avAudioUnitEffect, format: self.file!.processingFormat)
                self.engine.connect(avAudioUnitEffect, to: self.engine.mainMixerNode, format: self.file!.processingFormat)
                
                self.audioUnit = avAudioUnitEffect.auAudioUnit
                self.presetList = avAudioUnitEffect.auAudioUnit.factoryPresets ?? []
                
                done()
            }
        }
        else {
            done()
        }
    }
    
    func requestViewControllerWithCompletionHandler(_ completionHandler: (UIViewController?) -> Void) {
        audioUnit?.requestViewController { viewController in
            completionHandler(viewController)
        }
    }
}

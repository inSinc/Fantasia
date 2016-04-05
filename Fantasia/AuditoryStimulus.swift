//
//  AuditoryStimulus.swift
//  Fantasia
//
//  Created by Sinclair on 4/5/16.
//  Copyright © 2016 Sinclair. All rights reserved.
//

import Foundation
import AVFoundation

class AuditoryStimulus{
    var audioTrackName:String
    var audioTrackRating:Int
    var userAudioRating:Int
    var player:AVAudioPlayer
    
    init(audioTrackName:String, audioTrackRating:Int){
        self.audioTrackName = audioTrackName
        self.audioTrackRating = audioTrackRating
        userAudioRating = -1000
        self.player = AVAudioPlayer()
        let audioPath = NSBundle.mainBundle().pathForResource(audioTrackName, ofType: "mp3")!
        do{
            try self.player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            
        }catch{
            print("Audio player error. Please try again")
        }
    }
}
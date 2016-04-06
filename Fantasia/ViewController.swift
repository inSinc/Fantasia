//
//  ViewController.swift
//  Fantasia
//
//  Created by Sinclair on 4/5/16.
//  Copyright © 2016 Sinclair. All rights reserved.
//  Music from Jukedeck
//  Images from Unsplash

import UIKit

var visualStimuli = [VisualStimulus]()
var auditoryStimuli = [AuditoryStimulus]()

func save(){
    NSUserDefaults.standardUserDefaults().setObject(visualStimuli, forKey: "visualStimuli")
    NSUserDefaults.standardUserDefaults().setObject(auditoryStimuli, forKey: "auditoryStimuli")
}

class ViewController: UIViewController {
    var imageStrings = [String]()
    var audioStrings = [String]()
    var timer = NSTimer()
    var stimuliTimer = NSTimer()
    var ratingTimer = NSTimer()
    var current = 0
    
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var sadFace: UIImageView!
    @IBOutlet weak var happyFace: UIImageView!

    @IBOutlet weak var ratingSlider: UISlider!
    
    @IBOutlet weak var beginButton: UIButton!
    @IBAction func ratingSlider(sender: AnyObject) {
        visualStimuli[current].userImageRating = ratingSlider.value
        print(ratingSlider.value)
        current++
        happyFace.hidden = true
        sadFace.hidden = true
        ratingSlider.hidden = true
        ratingSlider.value = 0.0
        run()
    }
    
    @IBAction func beginButton(sender: AnyObject) {
        //run()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: Selector("run"), userInfo: nil, repeats: false)
        beginButton.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        loadData()
        ratingSlider.hidden = true
        happyFace.hidden = true
        sadFace.hidden = true
    }
    
    func run(){
        //let currentTime:Double = CACurrentMediaTime()
        currentImage.hidden = false
        currentImage.image = visualStimuli[current].image
        auditoryStimuli[current].player.play()
        stimuliTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("stopStimuli"), userInfo: nil, repeats: false)
        ratingTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("showRating"), userInfo: nil, repeats: false)
    }
    
    func showRating(){
        happyFace.hidden = false
        sadFace.hidden = false
        ratingSlider.hidden = false
    }
    
    func stopStimuli(){
        currentImage.hidden = true
        auditoryStimuli[current].player.stop()
    }
    
    func loadData(){
        for i in 0...20 {
            imageStrings.append("image\(i)")
            audioStrings.append("audio\(i)")
        }
        for i in 0...10{
            visualStimuli.append(VisualStimulus(imageName: imageStrings[0], imageRating: 5))
            visualStimuli.append(VisualStimulus(imageName: imageStrings[1], imageRating: -4))
            auditoryStimuli.append(AuditoryStimulus(audioTrackName: audioStrings[0], audioTrackRating: -3))
            auditoryStimuli.append(AuditoryStimulus(audioTrackName: audioStrings[1], audioTrackRating: 2))
        }
        
    }
    
    func pushToFirebase(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


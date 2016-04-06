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
    var timer = NSTimer()
    var stimuliTimer = NSTimer()
    var ratingTimer = NSTimer()
    var current = 0
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var sadFace: UIImageView!
    @IBOutlet weak var happyFace: UIImageView!

    @IBOutlet weak var ratingSlider: UISlider!
    @IBAction func reset(sender: AnyObject) {
        load()
        beginButton.hidden = false
    }
    @IBOutlet weak var beginButton: UIButton!
    @IBAction func ratingSlider(sender: AnyObject) {
        visualStimuli[current].userImageRating = ratingSlider.value
        print(ratingSlider.value)
        print("Name: \(visualStimuli[current].imageName) Post-rating: \(visualStimuli[current].userImageRating)")
        current++
        happyFace.hidden = true
        sadFace.hidden = true
        ratingSlider.hidden = true
        resetButton.hidden = true
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
        //load visual & auditory stimuli
        for i in 0...19{
            visualStimuli.append(VisualStimulus(imageName: "image\(i)", imageRating: 5))
            auditoryStimuli.append(AuditoryStimulus(audioTrackName: "audio0", audioTrackRating: 2))
        }
        load()
        resetButton.hidden = true
    }
    
    func load(){
        for i in 0...19{
            visualStimuli[i].userImageRating = -1000
        }
        shuffle()
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
        print("Pre-rating: \(visualStimuli[current].userImageRating)")
    }
    
    //shuffle/randomize stimuli
    func shuffle(){
        let c = visualStimuli.count
        for current in 0..<(c-1){
            let other = random()%c
            let another = random()%c
            swap(&visualStimuli[current], &visualStimuli[other])
            swap(&auditoryStimuli[current], &auditoryStimuli[other])
        }
    }
    
    func showRating(){
        happyFace.hidden = false
        sadFace.hidden = false
        ratingSlider.hidden = false
        resetButton.hidden = false
    }
    
    func stopStimuli(){
        currentImage.hidden = true
        auditoryStimuli[current].player.stop()
    }
    
    func pushToFirebase(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


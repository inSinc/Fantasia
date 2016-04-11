//
//  ViewController.swift
//  Fantasia
//
//  Created by Sinclair on 4/5/16.
//  Copyright © 2016 Sinclair. All rights reserved.

import UIKit
import Firebase

var visualStimuli = [VisualStimulus]()
var auditoryStimuli = [AuditoryStimulus]()
var loadedStimuli = false

func save(){
    NSUserDefaults.standardUserDefaults().setObject(visualStimuli, forKey: "visualStimuli")
    NSUserDefaults.standardUserDefaults().setObject(auditoryStimuli, forKey: "auditoryStimuli")
}

class ViewController: UIViewController {
    var timer = NSTimer()
    var stimuliTimer = NSTimer()
    var ratingTimer = NSTimer()
    var current = 0
    var stimuliTime = 9.0
    var numberOfStimuli = 20
    var firebaseRoot = Firebase()
    
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var currentImage: UIImageView!
    @IBOutlet weak var sadFace: UIImageView!
    @IBOutlet weak var happyFace: UIImageView!
    @IBOutlet weak var ratingSlider: UISlider!
    
    @IBAction func reset(sender: AnyObject) {
        //load()
        //beginButton.hidden = false
        //resetButton.hidden = true
    }
    
    @IBAction func ratingSlider(sender: AnyObject) {
        visualStimuli[current].userImageRating = ratingSlider.value
        //print(ratingSlider.value)
        //print("Viual: \(visualStimuli[current].imageName) Audio: \(auditoryStimuli[current].audioTrackName) Post-rating: \(visualStimuli[current].userImageRating)")
        current++
        happyFace.hidden = true
        sadFace.hidden = true
        ratingSlider.hidden = true
        resetButton.hidden = true
        ratingSlider.value = 0.0
        if(current==numberOfStimuli){
            pushToFirebase()
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.finishLabel.alpha = 1.0
            })
            //delaying segue dispatch
            let delay = 2.0
            let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(delay) * NSEC_PER_SEC))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), { () -> Void in
                    self.performSegueWithIdentifier("returnToDemographics", sender: nil)
            })
        }else{
            run()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        //establishing firebase root
        firebaseRoot = Firebase(url:"https://glowing-torch-3672.firebaseio.com/")
        //load visual & auditory stimuli
        if !loadedStimuli{
            for i in 0..<numberOfStimuli{
                visualStimuli.append(VisualStimulus(imageName: "image\(i)"))
            }
            for i in 1...numberOfStimuli/2{
                auditoryStimuli.append(AuditoryStimulus(audioTrackName: "happy\(i)"))
                auditoryStimuli.append(AuditoryStimulus(audioTrackName: "sad\(i)"))
            }
            //print("LOADED STIMULI")
            loadedStimuli = true
        }
        if stimuliTimeOverride >= 0 && stimuliTimeOverride < 10 {
            stimuliTime = Double(stimuliTimeOverride)
        }
        finishLabel.alpha = 0.0
        load()
        shuffle(CACurrentMediaTime())
        resetButton.hidden = true
        run()
    }
    
    func load(){
        current = 0
        for i in 0..<numberOfStimuli{
            visualStimuli[i].userImageRating = -1000
        }
        shuffle(CACurrentMediaTime())
        ratingSlider.hidden = true
        happyFace.hidden = true
        sadFace.hidden = true
    }
    
    func run(){
        //let currentTime:Double = CACurrentMediaTime()
        currentImage.hidden = false
        currentImage.image = visualStimuli[current].image
        auditoryStimuli[current].player.play()
        //print(auditoryStimuli[current].audioTrackName)
        //print(visualStimuli[current].imageName)
        //use dispatch async in future versions
        stimuliTimer = NSTimer.scheduledTimerWithTimeInterval(stimuliTime, target: self, selector: Selector("stopStimuli"), userInfo: nil, repeats: false)
        ratingTimer = NSTimer.scheduledTimerWithTimeInterval(stimuliTime, target: self, selector: Selector("showRating"), userInfo: nil, repeats: false)
        //print("Pre-rating: \(visualStimuli[current].userImageRating)")
    }
    
    //shuffle/randomize stimuli
    func shuffle(firstRandom:Double){
        let c = visualStimuli.count
        var other = Int(firstRandom)%c
        for current in 0..<(c-1){
            //let another = random()%c
            if(current != other){
                swap(&visualStimuli[current], &visualStimuli[other])
                swap(&auditoryStimuli[current], &auditoryStimuli[other])
            }
            other = random()%c
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
        //print("Sex: \(sex) Age: \(age) Musical Experience: \(musicalExperience)")
        //push sex, age, experience
        var audioNames = [String]()
        var visualNames = [String]()
        var userRatings = [Float]()
        for i in 0..<numberOfStimuli{
            audioNames.append(auditoryStimuli[i].audioTrackName)
            visualNames.append(visualStimuli[i].imageName)
            userRatings.append(visualStimuli[i].userImageRating)
            //print("\(audioNames[i]) \(visualNames[i]) \(userRatings[i])")
        }
        
        var toUpload = ["sex":"\(sex)", "age":"\(age)", "musicalExperience":"\(musicalExperience)"]
        for i in 0..<numberOfStimuli{
            toUpload["\(i)"] = "\(auditoryStimuli[i].audioTrackName) \(visualStimuli[i].imageName) \(visualStimuli[i].userImageRating)"
        }
        let newReference = firebaseRoot.childByAutoId()
        newReference.setValue(toUpload)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


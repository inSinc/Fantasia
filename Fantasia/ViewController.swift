//
//  ViewController.swift
//  Fantasia
//
//  Created by Sinclair on 4/5/16.
//  Copyright © 2016 Sinclair. All rights reserved.
//

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
    var current = 0;
    
    @IBOutlet weak var currentImage: UIImageView!

    @IBOutlet weak var ratingSlider: UISlider!
    
    @IBOutlet weak var beginButton: UIButton!
    @IBAction func ratingSliderEditingDidEnd(sender: AnyObject) {
        visualStimuli[current].userImageRating = ratingSlider.value
        run()
    }
    @IBAction func beginButton(sender: AnyObject) {
        //timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("run"), userInfo: nil, repeats: true)
        beginButton.alpha = 0
        run()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        loadData()
        ratingSlider.hidden = true
        currentImage.hidden = true
        
        
    }
    
    func run(){
        ratingSlider.hidden = true
        var currentTime:Double = CACurrentMediaTime()
        auditoryStimuli[current].player.play()
        while((CACurrentMediaTime()-currentTime) < 8.0){
            
            //print(CACurrentMediaTime())
        }
        auditoryStimuli[current].player.stop()
        currentImage.image = visualStimuli[current].image
        currentTime = CACurrentMediaTime()
        while((CACurrentMediaTime()-currentTime) < 1.0){
            
        }
        currentImage.hidden = true
        ratingSlider.hidden = false
        print("Hello World")
    }
    
    func loadData(){
        for i in 0...20 {
            imageStrings.append("image\(i)")
            audioStrings.append("audio\(i)")
        }
    }
    
    func pushToFirebase(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


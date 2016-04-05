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
    @IBOutlet weak var currentImage: UIImageView!

    @IBOutlet weak var ratingSlider: UISlider!
    
    @IBAction func ratingSliderEditingDidEnd(sender: AnyObject) {
    }
    @IBAction func beginButton(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
    }
    
    func loadData(){
        var imageStrings = [String]()
        var audioStrings = [String]()
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


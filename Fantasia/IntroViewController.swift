//
//  IntroViewController.swift
//  Fantasia
//
//  Created by Sinclair on 4/9/16.
//  Copyright © 2016 Sinclair. All rights reserved.
//

import UIKit

//male/female
//age
//musical experience

var sex:String = String()
var age:Int = Int()
var musicalExperience:String = String()

class IntroViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!

    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var musicalExperienceLabel: UILabel!
    @IBOutlet weak var sexInputField: UISegmentedControl!
    @IBOutlet weak var ageInputField: UITextField!

    @IBOutlet weak var musicalExperienceInput: UISegmentedControl!
    @IBAction func submitButton(sender: AnyObject) {
    }
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func moreInfoButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        ageInputField.backgroundColor = UIColor.blackColor()
        ageInputField.borderStyle = UITextBorderStyle.Line
        ageInputField.layer.borderColor = UIColor.whiteColor().CGColor
        initialAnimations()
        // Do any additional setup after loading the view.
    }
    
    func initialAnimations(){
        welcomeLabel.center.x = self.view.bounds.width/2
        welcomeLabel.center.y = self.view.bounds.height/2
        welcomeLabel.alpha = 0.0
        sexLabel.alpha = 0.0
        ageLabel.alpha = 0.0
        musicalExperienceLabel.alpha = 0.0
        sexInputField.alpha = 0.0
        ageInputField.alpha = 0.0
        musicalExperienceInput.alpha = 0.0
        submitButton.alpha = 0.0
        infoButton.alpha = 0.0
        //ageInputField.borderStyle = UITextBorderStyle.None
        UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.welcomeLabel.alpha = 1.0
            }) { (Bool) -> Void in
                
        }
        UIView.animateWithDuration(2.0, delay: 2.0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.welcomeLabel.center.y = 38.0
            }) { (Bool) -> Void in
                
        }
        UIView.animateWithDuration(2.0, delay: 4.0, options: UIViewAnimationOptions.AllowAnimatedContent, animations: { () -> Void in
            self.sexInputField.alpha = 1.0
            self.ageInputField.alpha = 1.0
            self.sexLabel.alpha = 1.0
            self.ageLabel.alpha = 1.0
            self.musicalExperienceInput.alpha = 1.0
            self.musicalExperienceLabel.alpha = 1.0
            self.submitButton.alpha = 1.0
            self.infoButton.alpha = 1.0
            }) { (Bool) -> Void in
                
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

}

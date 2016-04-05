//
//  VisualStimuli.swift
//  Fantasia
//
//  Created by Sinclair on 4/5/16.
//  Copyright © 2016 Sinclair. All rights reserved.
//

import Foundation
import UIKit

class VisualStimulus{
    var imageName:String
    var image:UIImage
    var imageRating:Int
    var userImageRating:Float
    
    init(imageName:String, imageRating:Int){
        self.imageName = imageName
        let filePath = NSBundle.mainBundle().pathForResource(imageName, ofType: ".jpeg")
        self.image = UIImage(contentsOfFile: filePath!)!
        self.imageRating = imageRating
        userImageRating = -1000.0
    }
}

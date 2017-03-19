//
//  ViewController.swift
//  AutoSpot v1
//
//  Created by Andy Peng on 2/19/15.
//  Copyright (c) 2015 Andy Peng/Daniel Shafrir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var coreLocationController:CoreLocationController?

    @IBAction func dropPin(sender: AnyObject) {
        if (self.coreLocationController != nil) {
            self.coreLocationController!.dropPin()
            self.coreLocationController?.dropPin()
        }
    }
    @IBOutlet var arrowImage: UIImageView!
    
    func rotateArrowImage(timer:NSTimer!){
        if (self.coreLocationController!.theta != nil) {
            UIView.animateWithDuration(0.2, animations: {self.arrowImage.transform = CGAffineTransformMakeRotation(CGFloat(self.coreLocationController!.theta!))})
            //println("!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coreLocationController = CoreLocationController()
        // Do any additional setup after loading the view, typically from a nib.
        NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "rotateArrowImage:", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
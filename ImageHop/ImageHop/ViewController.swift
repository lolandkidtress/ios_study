//
//  ViewController.swift
//  ImageHop
//
//  Created by jian chen on 16/7/12.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initBunny();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var bunnyMid: UIImageView!
    @IBOutlet weak var bunnyR1: UIImageView!
    @IBOutlet weak var bunnyR2: UIImageView!
    @IBOutlet weak var bunnyL1: UIImageView!
    @IBOutlet weak var bunnyL2: UIImageView!
    
    @IBOutlet weak var fpsUILabel: UILabel!
    
    @IBOutlet weak var SpeedSlider: UISlider!
    @IBOutlet weak var Stepper: UIStepper!
    @IBOutlet weak var HopsButton: UIButton!
    
    
    
    @IBAction func toggleHops(sender: AnyObject) {
        if(bunnyMid.isAnimating()){
            bunnyMid.stopAnimating()
            bunnyR2.stopAnimating()
            bunnyR1.stopAnimating()
            bunnyL1.stopAnimating()
            bunnyL2.stopAnimating()
            HopsButton.setTitle("Hops", forState: UIControlState.Normal)
            
            
        }else{
            bunnyMid.startAnimating()
            bunnyR2.startAnimating()
            bunnyR1.startAnimating()
            bunnyL1.startAnimating()
            bunnyL2.startAnimating()
            HopsButton.setTitle("Sit", forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func setSpeed(sender: AnyObject?) {
        
        print("SpeedSlider.value :" + String(SpeedSlider.value))
        bunnyMid.animationDuration = NSTimeInterval(2.0 - SpeedSlider.value);
        bunnyL1.animationDuration = bunnyMid.animationDuration + NSTimeInterval(arc4random_uniform(10))/10
        bunnyL2.animationDuration = bunnyL1.animationDuration + NSTimeInterval(arc4random_uniform(10))/10
        bunnyR1.animationDuration = bunnyL1.animationDuration
        bunnyR2.animationDuration = bunnyL2.animationDuration
        
        bunnyMid.startAnimating()
        bunnyR2.startAnimating()
        bunnyR1.startAnimating()
        bunnyL1.startAnimating()
        bunnyL2.startAnimating()
        
        HopsButton.setTitle("Sit", forState: UIControlState.Normal)
        
        let speed = String( format: "%1.2f hps" ,  self.SpeedSlider.value)
        fpsUILabel.text = speed
        
    }
    
    @IBAction func increamentStepper(sender: AnyObject) {
        
        print("Stepper.value:" + String(format: "1.2f", self.Stepper.value))
        SpeedSlider.value = Float(self.Stepper.value)
        setSpeed(nil)
    }
    
    
    func initBunny(){
        bunnyMid.animationImages = hopAnimationList().getHopAnimation();
        bunnyR1.animationImages = hopAnimationList().getHopAnimation();
        bunnyR2.animationImages = hopAnimationList().getHopAnimation();
        bunnyL1.animationImages = hopAnimationList().getHopAnimation();
        bunnyL2.animationImages = hopAnimationList().getHopAnimation();
        
        bunnyMid.animationDuration = 1.0
        bunnyR1.animationDuration = 1.0
        bunnyR2.animationDuration = 1.0
        bunnyL1.animationDuration = 1.0
        bunnyL2.animationDuration = 1.0
    }
    
}


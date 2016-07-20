//
//  ViewController.swift
//  gettingAttention
//
//  Created by jian chen on 16/7/15.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController , AudioServicesPlaySystemSoundDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var isPlaying = false
    
    @IBOutlet weak var userOutput: UILabel!

    @IBAction func doAlert(sender: AnyObject) {
        let alertController = UIAlertController(title: "do Alert", message: "just alert", preferredStyle: UIAlertControllerStyle.Alert )
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        
        presentViewController(alertController,animated:true,completion:nil)
        
    }
    
    
    @IBAction func doButtonAlert(sender: AnyObject) {
        let alertController = UIAlertController(title: "do button Alert", message: "alert lot button", preferredStyle: UIAlertControllerStyle.Alert )
        
        let nowAction = UIAlertAction(title: "Do Something now", style: UIAlertActionStyle.Default, handler:
            {( alertAction:UIAlertAction) in self.userOutput.text="Press Now"
                }
        )
        
        let laterAction = UIAlertAction(title: "Do Something later", style: UIAlertActionStyle.Default, handler:
            {( alertAction:UIAlertAction) in self.userOutput.text="Press Later"
            }
        )
        
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler:
            {( alertAction:UIAlertAction) in self.userOutput.text="Press Cancel"
            }
        )
        
        alertController.addAction(nowAction)
        alertController.addAction(laterAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController,animated:true,completion:nil)

    }
    
    @IBAction func doInputAlert(sender: AnyObject) {
        let alertController = UIAlertController(title: "Email", message: "Please enter Email", preferredStyle: UIAlertControllerStyle.Alert )
        
        alertController.addTextFieldWithConfigurationHandler({
            (textField:UITextField) in
            textField.placeholder="Email"
            textField.keyboardType=UIKeyboardType.EmailAddress
            textField.secureTextEntry = true
        })
        
        let textAction = UIAlertAction(title: "OK",
                                       style: UIAlertActionStyle.Default,
                                       handler:
            {( alertAction:UIAlertAction) in let email : String = alertController.textFields![0].text!
                self.userOutput.text="Entered '\(email)'"
            }
        )
        
        alertController.addAction(textAction)
        presentViewController(alertController,animated:true,completion:nil)
    }
    
    @IBAction func doAction(sender: AnyObject) {
        let alertController = UIAlertController(title: "ActionSheet", message: "choose a lot of lists", preferredStyle: UIAlertControllerStyle.ActionSheet )
        
        
        let negoAction = UIAlertAction(title: "nego", style: UIAlertActionStyle.Default, handler:
            {( alertAction:UIAlertAction) in self.userOutput.text="Press nego"
            }
        )
        
        let comAction = UIAlertAction(title: "com", style: UIAlertActionStyle.Default, handler:
            {( alertAction:UIAlertAction) in self.userOutput.text="Press com"
            }
        )
        
        let destroyAction = UIAlertAction(title: "destroy", style: UIAlertActionStyle.Destructive, handler:
            {( alertAction:UIAlertAction) in self.userOutput.text="Press destroy"
            }
        )
        
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler:
            {( alertAction:UIAlertAction) in self.userOutput.text="Press cancel"
            }
        )
        

        alertController.addAction(negoAction)
        alertController.addAction(comAction)
        alertController.addAction(destroyAction)
        alertController.addAction(cancelAction)
        
        
        if (alertController.popoverPresentationController != nil){
            alertController.popoverPresentationController!.sourceView = sender as! UIButton
            alertController.popoverPresentationController!.sourceRect = (sender as! UIButton).bounds
        }
        
        presentViewController(alertController,animated:true,completion:nil)

    }
    
    @IBAction func doPlaySound(sender: AnyObject) {
        
        
        var soundID: SystemSoundID = 0
        let soundFile: String = NSBundle.mainBundle().pathForResource("soundeffect", ofType: "wav")!
        
        let soundURL: NSURL = NSURL(fileURLWithPath: soundFile)
        
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
        
        self.userOutput.text="Play Sound"
        
    }
    
    @IBAction func doPlayAlertSound(sender: AnyObject) {
        var soundID: SystemSoundID = 0
        let soundFile: String = NSBundle.mainBundle().pathForResource("alertsound", ofType: "wav")!
        
        let soundURL: NSURL = NSURL(fileURLWithPath: soundFile)
        
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        AudioServicesPlayAlertSound(soundID)
        self.userOutput.text="Play Alert Sound"
    }
    
    @IBAction func doVibrate(sender: AnyObject) {
        
        let soundID = SystemSoundID(kSystemSoundID_Vibrate)
        //振动
        AudioServicesPlaySystemSound(soundID)
    }
    
    
    @IBAction func doCallback(sender: AnyObject) {
        if !isPlaying {
            var soundID: SystemSoundID = 0
            let soundFile: String = NSBundle.mainBundle().pathForResource("alertsound", ofType: "wav")!
            
            let soundURL: NSURL = NSURL(fileURLWithPath: soundFile)
            
            AudioServicesCreateSystemSoundID(soundURL, &soundID)
            let proc: AudioServicesSystemSoundCompletionProc = MyAudioServicesSystemSoundCompletionHandler
            AudioServicesAddSystemSoundCompletion(soundID, nil, nil, proc,
                                                  UnsafeMutablePointer(unsafeAddressOf(self)))
            //播放声音
            AudioServicesPlaySystemSound(soundID)
            isPlaying = true
            self.userOutput.text="Play Alert Sound"
        }else{
            self.userOutput.text="Sound Block"

        }
        
        
        
    }
    
    func audioServicesPlaySystemSoundCompleted(soundID: SystemSoundID) {
        print("Completion")
        isPlaying = false
        self.userOutput.text="Play Completion"
        AudioServicesRemoveSystemSoundCompletion(soundID)
        AudioServicesDisposeSystemSoundID(soundID)
    }
    

    
}

@objc protocol AudioServicesPlaySystemSoundDelegate  {
    func audioServicesPlaySystemSoundCompleted(soundID: SystemSoundID)
}

func MyAudioServicesSystemSoundCompletionHandler(soundID: SystemSoundID,
                                                 inClientData: UnsafeMutablePointer<Void>) {
    let delegate = unsafeBitCast(inClientData, AudioServicesPlaySystemSoundDelegate.self)
    delegate.audioServicesPlaySystemSoundCompleted(soundID)
}


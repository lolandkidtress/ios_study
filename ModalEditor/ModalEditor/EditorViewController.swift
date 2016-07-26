//
//  EditorViewController.swift
//  ModalEditor
//
//  Created by jian chen on 16/7/26.
//  Copyright © 2016年 jian chen. All rights reserved.
//


import UIKit

class EditorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSizeMake(600,400)
    }
    
    override func viewWillAppear(animated: Bool) {
        emailField.text =
        (presentingViewController as! ViewController).emailLabel.text
        super.viewWillAppear(animated)
    }

    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func updateEmail(sender: AnyObject) {
        (presentingViewController as! ViewController).emailLabel.text
        = emailField.text
        
        //不连接exit,可以用如下代码回退
        //self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func hideKeyBoard(sender: AnyObject) {
        emailField.resignFirstResponder()
    }
    
}

//
//  ViewController.swift
//  ModalEditor
//
//  Created by jian chen on 16/7/20.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailLabel.text = "example@gmail.com"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func exitToHere(sender : UIStoryboardSegue){
        
    }

    @IBOutlet weak var emailLabel: UILabel!
    
    
}


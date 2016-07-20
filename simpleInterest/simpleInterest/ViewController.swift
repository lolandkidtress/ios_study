//
//  ViewController.swift
//  simpleInterest
//
//  Created by jian chen on 16/7/6.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var amountField : UITextField?
    @IBOutlet weak var rateField : UITextField?
    @IBOutlet weak var yearsField : UITextField?
    
    @IBOutlet weak var resultField : UITextField?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var simpleInterest : SimpleInterest = SimpleInterest();

    @IBAction func CalcuButtonClick(sender : UIButton){
        var result:Double;
        result = simpleInterest.CalcuSimpleInterest(
            ((amountField?.text)! as NSString).doubleValue,
            rate :((rateField?.text)! as NSString).doubleValue,
            years:((yearsField?.text)! as NSString).integerValue);
        self.rateField?.text = result.description;
    }

}


//
//  ViewController.swift
//  TxtTemplate
//
//  Created by jian chen on 16/7/8.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var PlaceTextFiled: UITextField!

    @IBOutlet weak var verbTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var templateTextField: UITextView!
    
    @IBOutlet weak var storyTextField: UITextView!
    
    
    //createStory 按钮
    @IBAction func CreateStory(sender: AnyObject) {
        
        var story = templateTextField.text;
        story = story.stringByReplacingOccurrencesOfString("<place>", withString: PlaceTextFiled.text!);
        story = story.stringByReplacingOccurrencesOfString("<verb>", withString: verbTextField.text!);
        story = story.stringByReplacingOccurrencesOfString("<number>", withString: numberTextField.text!);
        
        storyTextField.text = story;
    }
    
    //文本框 Done Did end on exit触发
    @IBAction func hideKeyBoard(sender: AnyObject) {
        print("hideKeyBoard");
        funcHideKeyBoard();
        
    }
    
    //背景button被点击后的事件
    @IBAction func onClick(sender:AnyObject){
        print("button click");
        funcHideKeyBoard();
    }
    
    //将页面上的输入框的键盘隐藏
    func funcHideKeyBoard(_: Void){
        PlaceTextFiled.resignFirstResponder();
        verbTextField.resignFirstResponder();
        numberTextField.resignFirstResponder();
    }
    
    
    
}


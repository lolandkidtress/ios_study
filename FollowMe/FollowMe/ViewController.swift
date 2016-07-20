//
//  ViewController.swift
//  FollowMe
//
//  Created by jian chen on 16/7/6.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum ButtonColor : Int {
        case Red = 1;
        case Brown = 2;
        case Orange = 3;
        case Blue = 4;
        
    }
    
    enum whoseTurn {
        case Player;
        case Computer;
    }
    
    //当前玩家
    var currentTurn:whoseTurn = .Player;
    
    //按钮顺序
    var inputs = [ButtonColor]();
    //按钮高亮持续时间
    var highlightTime:Double = 0.5;
    var delayTime = 0.0;
    var indexOfNextButtonTouch:Int = 0;
    var currentLevel:Int = 1;
    var bestLevel:Int = 0;
    //上一次的随机数
    var tempRandom:Int = 4;
    
    
    @IBOutlet weak var bestRecord : UILabel?;
    @IBOutlet weak var bestRecordNum : UITextField?;
    
    @IBOutlet weak var levelLable : UILabel?;
    @IBOutlet weak var levelText : UITextField?;

    @IBOutlet weak var redButton : UIButton!;
    @IBOutlet weak var brownButton : UIButton!;
    @IBOutlet weak var orangeButton : UIButton!;
    @IBOutlet weak var blueButton : UIButton!;


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.screenLoad();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //根据颜色返回对用的按钮
    func buttonbyColor(color : ButtonColor)-> UIButton {
        switch color {
        case .Red:
            return redButton;
        case .Brown:
            return brownButton;
        case .Orange:
            return orangeButton;
        case .Blue:
            return blueButton;
        }
    }
    
    //根据顺序,对应按钮显示动画效果
    func playSequence(index:Int,highlightTime:Double){
        currentTurn = .Computer;
        //如果按钮顺序显示结束了
        if index == inputs.count{
            currentTurn = .Player;
            return ;
        }
        
        let button :UIButton = buttonbyColor(inputs[index]);
        print(button.currentTitle! +  " to be light")
        let originColor = button.backgroundColor;
        let highlightColor = UIColor.whiteColor();
        
        UIView.animateWithDuration(highlightTime,
                                   delay: delayTime,
                                   options: UIViewAnimationOptions.BeginFromCurrentState,
                                   animations:{
                                    button.backgroundColor = highlightColor;
            },
                                   completion: {
                                    finished in button.backgroundColor = originColor;
                                    self.playSequence(index+1, highlightTime: highlightTime)
                                    
        });
    }
    
    //随机生成一个按钮颜色
    func randomButton(_: Void) -> ButtonColor{
        var v:Int = Int(arc4random_uniform(UInt32(4)))+1 ;
        //保证和上一次不重复
        while tempRandom == v {
            v = Int(arc4random_uniform(UInt32(4)))+1 ;
        }
        tempRandom = v;
        
        let result = ButtonColor(rawValue: v)!;
        return result;
    }
    
    func screenLoad(_: Void){
        self.levelText?.text = String(currentLevel);
        self.bestRecordNum?.text = "0";
    }
    
    func initGame(_: Void){
        self.levelText?.text = String(currentLevel);
        self.bestRecordNum?.text = "0";
        inputs = [ButtonColor]();
        currentLevel = 1;
        self.levelText?.text = String(currentLevel);
        currentTurn = .Computer;
        indexOfNextButtonTouch = 0;
        currentTurn = .Computer;
    }
    
    func winGame(_: Void){
        bestLevel = currentLevel;
        currentLevel+=1;
        self.bestRecordNum?.text = String(bestLevel);
        currentTurn = .Computer;
        
        let win : UIAlertController = UIAlertController(title: "Correct", message: "Congralation", preferredStyle: UIAlertControllerStyle.Alert)
        let resetAction = UIAlertAction(title:"Yes",style:UIAlertActionStyle.Default,handler:nil)
        win.addAction(resetAction)
        
        self.presentViewController(win, animated: true, completion: nil)
    }
    
    func loseGame(_: Void){
        print("game over");
        
        let lose : UIAlertController = UIAlertController(title: "Oops..", message: "Congralation", preferredStyle: UIAlertControllerStyle.Alert)
        let resetAction = UIAlertAction(title:"I knew",style:UIAlertActionStyle.Cancel,handler:nil)
        lose.addAction(resetAction)
        self.presentViewController(lose, animated: true, completion: nil)
        
        initGame();
    
    }
    
    
    @IBAction func buttonTouched(sender : UIButton){
        let buttonTag:Int = sender.tag;
        
        if currentTurn == .Computer{
            //非玩家
            print("系统演示中");
            return;
        }
        
        let colorTouched = ButtonColor(rawValue: buttonTag);
        
        print(String(colorTouched) + "be clicked");
        
        if colorTouched == inputs[indexOfNextButtonTouch]{
            indexOfNextButtonTouch = indexOfNextButtonTouch+1;
            if indexOfNextButtonTouch == inputs.count{
                indexOfNextButtonTouch=0;
                winGame();
            }else{
                //还没有点完
            }
        }else{
            loseGame();
            indexOfNextButtonTouch=0;
        }
        
        
    }
    
    @IBAction func startButtonClick(sender : UIButton){
        print("startButtonClick");
        inputs = [ButtonColor]();
        for _ in 0 ..< currentLevel {
           inputs += [randomButton()];
        }

        print(inputs);
        
        self.levelText?.text = String(currentLevel);
        
        playSequence(0,highlightTime: 0.5);
        currentTurn = .Player
        indexOfNextButtonTouch = 0;
    }
    
    @IBAction func resetButtonClick(sender : UIButton){
        print("resetButtonClick");
        bestLevel=0;
        self.bestRecordNum?.text = String(bestLevel);
        initGame();
        
    }

}


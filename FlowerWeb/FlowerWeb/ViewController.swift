//
//  ViewController.swift
//  FlowerWeb
//
//  Created by jian chen on 16/7/14.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        flowerDetailView.hidden = true
        getFlower(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var colorChoice: UISegmentedControl!
    @IBOutlet weak var getFlower: UIButton!
    
    @IBOutlet weak var flowerView: UIWebView!
    @IBOutlet weak var flowerDetailView: UIWebView!
    

    @IBAction func toggleFlowerDetail(sender: AnyObject) {
        flowerDetailView.hidden = !(sender as! UISwitch).on
    }
    
    @IBAction func getFlower(sender: AnyObject?) {
        var imageURL : NSURL
        var detaiURL : NSURL
        var imageURLString : String
        var detailURLString : String
        var color : String
        let sessionID : Int = random ()%5000
        
        color = colorChoice.titleForSegmentAtIndex(colorChoice.selectedSegmentIndex)!
        
        imageURLString = ImageList().getImageURL(color);
        detailURLString = ImageList().getImageDetailURL(color);

        imageURL = NSURL(string : imageURLString)!
        detaiURL = NSURL(string : detailURLString)!
        
        flowerView.loadRequest(NSURLRequest(URL : imageURL))
        flowerDetailView.loadRequest(NSURLRequest(URL : detaiURL))
        
        
    }
    
    
    
    
}


//
//  ImageList.swift
//  FlowerWeb
//
//  Created by jian chen on 16/7/14.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import Foundation

class ImageList {
    let ImageDic : [String:String] = ["Pink":"http://img1.imgtn.bdimg.com/it/u=2097870321,963960958&fm=21&gp=0.jpg",
                                      "Green" : "http://img5.imgtn.bdimg.com/it/u=3732793912,1940191151&fm=21&gp=0.jpg",
                                      "Red" : "http://static.zhulong.com/photo/small/200801/10/137410_3_0_0_560_w_0.jpg",
                                      "Yellow" : "http://img0.imgtn.bdimg.com/it/u=1591959050,425665786&fm=21&gp=0.jpg"
    ]
    
    let ImageDetailDic : [String:String] = ["Pink":"http://img1.imgtn.bdimg.com/it/u=2097870321,963960958&fm=21&gp=0.jpg",
                                            "Green" : "http://img5.imgtn.bdimg.com/it/u=3732793912,1940191151&fm=21&gp=0.jpg",
                                            "Red" : "http://static.zhulong.com/photo/small/200801/10/137410_3_0_0_560_w_0.jpg",
                                            "Yellow" : "http://img0.imgtn.bdimg.com/it/u=1591959050,425665786&fm=21&gp=0.jpg"
    ]
    
    enum ImageListURL : String{
        case Pink = "http://img1.imgtn.bdimg.com/it/u=2097870321,963960958&fm=21&gp=0.jpg"
        case Green = "http://img5.imgtn.bdimg.com/it/u=3732793912,1940191151&fm=21&gp=0.jpg"
        case Red = "http://static.zhulong.com/photo/small/200801/10/137410_3_0_0_560_w_0.jpg"
        case Yellow = "http://img0.imgtn.bdimg.com/it/u=1591959050,425665786&fm=21&gp=0.jpg"
    }
    
    func getImageURL(color:String) -> String {
        return ImageDic[color]!;
    }
    
    func getImageDetailURL(color:String) -> String {
        return ImageDetailDic[color]!;
    }
}

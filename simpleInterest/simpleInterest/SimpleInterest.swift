//
//  SimpleInterest.swift
//  simpleInterest
//
//  Created by jian chen on 16/7/6.
//  Copyright © 2016年 jian chen. All rights reserved.
//

import Foundation

class SimpleInterest{
    func CalcuSimpleInterest(amount:Double,rate :Double,years:Int) -> Double{
        let Rate = rate/100.0;
        let interest = Double(years)*Rate*amount;
        return amount+interest;
        
    }
}

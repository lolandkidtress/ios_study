//
//  HorizontalView.swift
//  demo
//
//  Created by qing on 16/7/11.
//  Copyright © 2016年 qing. All rights reserved.
//

import UIKit

class HorizontalView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    private var iTableView: UITableView!
    private var count: Int = 0
    
    init(frame: CGRect, count: Int) {
        super.init(frame: frame)
        
        self.count = count
        
        iTableView = UITableView(frame: CGRectMake(0, 0, frame.size.height, frame.size.width))
        iTableView.center = CGPointMake(frame.size.width / 2, frame.size.height / 2)
        iTableView.dataSource = self
        iTableView.delegate = self
        iTableView.separatorStyle = .None
        iTableView.showsVerticalScrollIndicator = false
        self.addSubview(iTableView)
        
        iTableView.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI) / 2)
        iTableView.registerNib(UINib(nibName: "HorizontalCell", bundle: nil), forCellReuseIdentifier: "kCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    * 产生随机位置
    */
    func random(closure: ((random: Int) -> Void)?) {
        let r = Int(arc4random() % UInt32(self.count))
        self.iTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: r, inSection: 0), atScrollPosition: .Middle, animated: true)
        if let c = closure {
            c(random: r)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("kCell") as! HorizontalCell
        cell.titleLabel.text = "\(indexPath.row)"
        
        cell.contentView.backgroundColor = getRandomColor()
        
        return cell
    }
    
    private func getRandomColor() -> UIColor {
        let r = CGFloat(arc4random() % 255)
        let g = CGFloat(arc4random() % 255)
        let b = CGFloat(arc4random() % 255)
        
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updateOffset(scrollView)
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        updateOffset(scrollView)
    }
    
    private func updateOffset(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.y == 0 {
            iTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: count - 1, inSection: 0), atScrollPosition: .Top, animated: false)
        }
        else if offset.y == scrollView.contentSize.height - scrollView.bounds.size.height {
            iTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: false)
        }
    }

}

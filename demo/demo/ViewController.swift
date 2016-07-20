//
//  ViewController.swift
//  demo
//
//  Created by qing on 16/7/11.
//  Copyright © 2016年 qing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    // 水平方向
    private var horizontalView: HorizontalView!
    // 展开视图
    private var collectionView: UICollectionView!
    // 行数
    private var count: Int = 30
    private var chooseButton: UIButton!
    private var textLabel: UILabel!
    
    // button tag
    private enum FuncButtonTag: Int {
        case Random = 100
        case Expand
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()

        addHorizontalView()
        addCollectionView()
        
        addFuncButton()
    }

    /**
    * collection view
    */
    private func addCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.hidden = true
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: .DirectionLeftToRight, metrics: nil, views: ["collectionView": collectionView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collectionView]|", options: .DirectionLeftToRight, metrics: nil, views: ["collectionView": collectionView]))
        
        collectionView.registerNib(UINib(nibName: "ItemCollectionViewCell", bundle: nil) ,forCellWithReuseIdentifier: "kCell")
        
        let spacing: CGFloat = 2
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        let columnsNum = 4
        let collectionViewWidth = self.view.bounds.size.width
        let itemWidth = (collectionViewWidth - spacing * CGFloat(columnsNum-1))
            / CGFloat(columnsNum)
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth)
        
        collectionView.reloadData()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("kCell", forIndexPath: indexPath) as! ItemCollectionViewCell
        cell.titleLabel.text = "\(indexPath.row)"
        cell.contentView.backgroundColor = getRandomColor()
        return cell
    }
    
    
    /**
    * 添加水平滚动视图
    */
    private func addHorizontalView() {
        horizontalView = HorizontalView(frame: CGRectMake(0, 0, self.view.frame.width, 200), count: count)
        self.view.addSubview(horizontalView)
    }
    
    
    /**
    * 添加功能
    */
    private func addFuncButton() {
        
        // 随机选择
        chooseButton = UIButton(type: .System)
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        chooseButton.setTitle("随机选择", forState: .Normal)
        chooseButton.tag = FuncButtonTag.Random.rawValue
        chooseButton.addTarget(self, action: #selector(buttonPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(chooseButton)
        
        self.view.addConstraint(NSLayoutConstraint(item: chooseButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: chooseButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
        
        // 展开
        let expandButton = UIButton(type: .System)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.setTitle("展开", forState: .Normal)
        expandButton.setTitle("收起", forState: .Selected)
        expandButton.tag = FuncButtonTag.Expand.rawValue
        expandButton.addTarget(self, action: #selector(buttonPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(expandButton)
        
        self.view.addConstraint(NSLayoutConstraint(item: expandButton, attribute: .CenterX, relatedBy: .Equal, toItem: chooseButton, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: expandButton, attribute: .CenterY, relatedBy: .Equal, toItem: chooseButton, attribute: .CenterY, multiplier: 1, constant: 40))
        
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textLabel)
        
        self.view.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: -40))
    }
    
    func buttonPressed(sender: UIButton) {
        if sender.tag == FuncButtonTag.Random.rawValue {
            // 产生随机位置
            horizontalView.random({ [weak self] (random) in
                if let weakSelf = self {
                    weakSelf.textLabel.text = "\(random)"
                }
            })
        }
        else if sender.tag == FuncButtonTag.Expand.rawValue {
            // 展开
            sender.selected = !sender.selected
            collectionView.hidden = !sender.selected
            chooseButton.hidden = sender.selected
            textLabel.hidden = sender.selected
        }
    }
    
    private func getRandomColor() -> UIColor {
        let r = CGFloat(arc4random() % 255)
        let g = CGFloat(arc4random() % 255)
        let b = CGFloat(arc4random() % 255)
        
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }

}


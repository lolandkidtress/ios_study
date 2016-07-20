//
//  HorizontalCell.swift
//  demo
//
//  Created by qing on 16/7/11.
//  Copyright © 2016年 qing. All rights reserved.
//

import UIKit

class HorizontalCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) / 2)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

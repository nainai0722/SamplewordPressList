//
//  NewsCell.swift
//  SampleBrowserBase
//
//  Created by apple on 2018/09/16.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

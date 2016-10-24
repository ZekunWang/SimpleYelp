//
//  TableSectionHeader.swift
//  Yelp
//
//  Created by Zekun Wang on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class TableSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet var titleLabel: UILabel!
    
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

//
//  CheckCell.swift
//  Yelp
//
//  Created by Zekun Wang on 10/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CheckCell: UITableViewCell {
    
    @IBOutlet var optionLabel: UILabel!
    @IBOutlet var selectedImageView: UIImageView!
    
    var expanded: Bool!
    var option: Option! {
        didSet {
            if (option == nil) {
                print("option is nil")
                return
            }
            optionLabel.text = option.label
            if expanded != nil && expanded {
                if option.selected {
                    selectedImageView.image = UIImage(named: "check_icon")
                } else {
                    selectedImageView.image = UIImage(named: "uncheck_icon")
                }
                selectedImageView.contentMode = UIViewContentMode.scaleAspectFill
            } else {
                selectedImageView.image = UIImage(named: "down_icon")
                selectedImageView.contentMode = UIViewContentMode.center
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

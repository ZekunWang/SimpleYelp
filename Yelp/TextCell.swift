//
//  TextCell.swift
//  Yelp
//
//  Created by Zekun Wang on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet var addressTextField: UITextField!
    
    var option: Option! {
        didSet {
            if option != nil && option.value != "" {
                addressTextField.text = option.value
            }
        }
    }
    
    @IBAction func onAddressChanged(_ sender: AnyObject) {
        if option != nil {
            print("new address: \(sender.text!)")
            option.value = sender.text!
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

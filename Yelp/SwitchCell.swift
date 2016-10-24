//
//  SwitchCell.swift
//  Yelp
//
//  Created by Zekun Wang on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate {
    func onSwitchDone(_ switchCell: SwitchCell)
}

class SwitchCell: UITableViewCell {

    @IBOutlet var optionLabel: UILabel!
    @IBOutlet var optionSwitch: UISwitch!
    @IBOutlet var seeAllLabel: UILabel!
    
    
    var indexPath: IndexPath?
    var delegate: SwitchCellDelegate?
    
    var option: Option! {
        didSet{
            if option == nil {
                self.optionLabel.isHidden = true
                self.optionSwitch.isHidden = true
                self.seeAllLabel.isHidden = false
            } else {
                self.optionLabel.text = option.label
                self.optionSwitch.isOn = option.selected
                
                self.optionLabel.isHidden = false
                self.optionSwitch.isHidden = false
                self.seeAllLabel.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onSwitchChanged(_ sender: AnyObject) {
        if option != nil {
            optionSwitch.isSelected = !optionSwitch.isSelected
            option.selected = !option.selected
            print("switch is now: \(optionSwitch.isSelected)")
            delegate?.onSwitchDone(self)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

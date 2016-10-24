//
//  SegControlCell.swift
//  Yelp
//
//  Created by Zekun Wang on 10/24/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SegControlCell: UITableViewCell {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    let blue = UIColor(red:0, green:0.48, blue:1, alpha:1.0)
    
    var option: Option! {
        didSet {
            if option == nil {
                return
            }
            
            segmentedControl.selectedSegmentIndex = option.selected ? 1 : 0
            setTintColor()
        }
    }
    
    func setTintColor() {
        if option.selected {
            segmentedControl.subviews[1].tintColor = UIColor.lightGray
            segmentedControl.subviews[0].tintColor = blue
        } else {
            segmentedControl.subviews[1].tintColor = blue
            segmentedControl.subviews[0].tintColor = UIColor.lightGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let attr = NSDictionary(object: UIFont(name: "HelveticaNeue", size: 15.0)!, forKey: NSFontAttributeName as NSCopying)
        segmentedControl.setTitleTextAttributes(attr as [NSObject : AnyObject], for: .normal)
    }
    
    @IBAction func onSegmentedControlChanged(_ sender: AnyObject) {
        option.selected = segmentedControl.selectedSegmentIndex == 1
        setTintColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

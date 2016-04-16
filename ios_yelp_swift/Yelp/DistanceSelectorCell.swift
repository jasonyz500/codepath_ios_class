//
//  DistanceSelectorCell.swift
//  Yelp
//
//  Created by Jason Zhou on 9/21/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DistanceSelectorCellDelegate {
    optional func distanceSelectorCell(distanceSelectorCell: DistanceSelectorCell, didChangeSelection value: Int)
}

class DistanceSelectorCell: UITableViewCell {

    @IBOutlet weak var segmentedPicker: UISegmentedControl!
    
    weak var delegate: DistanceSelectorCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentedPicker.addTarget(self, action: "onChangeSegment", forControlEvents: UIControlEvents.ValueChanged)        // Initialization code
    }
    
    func onChangeSegment() {
        delegate?.distanceSelectorCell!(self, didChangeSelection: segmentedPicker.selectedSegmentIndex)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

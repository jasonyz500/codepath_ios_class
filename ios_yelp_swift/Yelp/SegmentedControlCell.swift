//
//  SegmentedControlCell.swift
//  Yelp
//
//  Created by Jason Zhou on 9/21/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SegmentedControlCellDelegate {
    optional func segmentedControlCell(segmentedControlCell: SegmentedControlCell, didChangeSelection value: Int)
}

class SegmentedControlCell: UITableViewCell {

    @IBOutlet weak var segmentedPicker: UISegmentedControl!

    weak var delegate: SegmentedControlCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentedPicker.addTarget(self, action: "onChangeSegment", forControlEvents: UIControlEvents.ValueChanged)        // Initialization code
    }

    func onChangeSegment() {
        delegate?.segmentedControlCell!(self, didChangeSelection: segmentedPicker.selectedSegmentIndex)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

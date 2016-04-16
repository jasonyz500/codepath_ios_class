//
//  DealsCell.swift
//  Yelp
//
//  Created by Jason Zhou on 9/21/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol DealsCellDelegate {
    func dealsCell(dealsCell: DealsCell, didChangeValue value: Bool)
}

class DealsCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    var delegate: DealsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func switchValueChanged() {
        delegate?.dealsCell(self, didChangeValue: onSwitch.on)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

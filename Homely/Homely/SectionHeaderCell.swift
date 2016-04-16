//
//  SectionHeaderCell.swift
//  Homely
//
//  Created by Jason Zhou on 10/15/15.
//  Copyright © 2015 lollerballer. All rights reserved.
//

import UIKit

@objc protocol SectionHeaderCellDelegate {
    optional func sectionHeaderCell(sectionHeaderCell: SectionHeaderCell, type: String)
}

class SectionHeaderCell: UITableViewCell {

    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var delegate: SectionHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(rgb: 0x251605)
        headerLabel.textColor = UIColor(rgb: 0x9BBEC7)
        // Initialization code
    }
    @IBAction func onTapAdd(sender: UITapGestureRecognizer) {
        delegate?.sectionHeaderCell!(self, type: "add")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

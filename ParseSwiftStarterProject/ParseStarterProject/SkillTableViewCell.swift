//
//  SkillTableViewCell.swift
//  Kiwi
//
//  Created by Pranav Madanahalli on 7/19/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SkillTableViewCell: UITableViewCell {

    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var skill: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }

}

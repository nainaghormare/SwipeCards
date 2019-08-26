//
//  CohenTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/30/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class CohenTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCohenQue  : UILabel!
    @IBOutlet weak var btnYes       : CustomButton!
    @IBOutlet weak var btnNo        : CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCohenQue.font            = Fonts.demi18
        
        btnNo.titleLabel?.font      = Fonts.mediumFont13
        btnYes.titleLabel?.font     = Fonts.mediumFont13
    }
    
    override func layoutSubviews() {
        btnNo.cornerRadiusValue     = btnNo.frame.height/2
        btnYes.cornerRadiusValue    = btnYes.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

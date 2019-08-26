//
//  OverviewSubpointTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/2/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class OverviewSubpointTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSubpointNumber    : UILabel!
    @IBOutlet weak var lblSubpoint          : UILabel!
    @IBOutlet weak var widthInner           : NSLayoutConstraint!
    @IBOutlet weak var subpointNumber       : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblSubpointNumber.font              = Fonts.demi25
        lblSubpoint.font                    = Fonts.mediumFont13
        widthInner.constant                 = 39*(UIDevice().screenHeight/812)
        subpointNumber.cornerRadiusView     = widthInner.constant/2
        subpointNumber.borderWidthView      = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



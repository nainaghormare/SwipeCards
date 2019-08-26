//
//  GenderTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/29/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class GenderTableViewCell: UITableViewCell {

    @IBOutlet weak var txtFieldName     : CustomTextField!
    @IBOutlet weak var txtFieldGender   : CustomTextField!
    @IBOutlet weak var btnGender        : UIButton!
    @IBOutlet weak var lblName          : UILabel!
    @IBOutlet weak var lblGender        : UILabel!
    @IBOutlet weak var grnderContraint  : NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtFieldName.font               = Fonts.mediumFont21
        txtFieldGender.font             = Fonts.mediumFont21
        lblName.font                    = Fonts.semiBoldFont13
        lblGender.font                  = Fonts.semiBoldFont13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

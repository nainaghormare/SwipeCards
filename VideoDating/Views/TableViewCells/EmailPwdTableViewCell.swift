//
//  EmailPwdTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/29/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class EmailPwdTableViewCell: UITableViewCell {

    @IBOutlet weak var txtFieldEmailPwd : CustomTextField!
    @IBOutlet weak var btnPwdImage      : UIButton!
    @IBOutlet weak var lblemailPwd      : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtFieldEmailPwd.font           = Fonts.mediumFont21
        lblemailPwd.font                = Fonts.semiBoldFont13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

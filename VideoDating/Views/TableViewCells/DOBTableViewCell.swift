//
//  DOBTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/29/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class DOBTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDOB   : UILabel!
    @IBOutlet weak var lblDate  : UILabel!
    @IBOutlet weak var lblMonth : UILabel!
    @IBOutlet weak var lblYear  : UILabel!
    @IBOutlet weak var btnDate  : UIButton!
    @IBOutlet weak var btnMonth : UIButton!
    @IBOutlet weak var btnYear  : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblDate.font            = Fonts.mediumFont21
        lblMonth.font           = Fonts.mediumFont21
        lblYear.font            = Fonts.mediumFont21
        lblDOB.font             = Fonts.semiBoldFont13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

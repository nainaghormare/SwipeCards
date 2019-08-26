//
//  OverviewPointTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/2/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class OverviewPointTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView      : UIImageView!
    @IBOutlet weak var subImgView   : UIImageView!
    @IBOutlet weak var lblPoint     : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblPoint.font = Fonts.mediumFont13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ReviewTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/23/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var lblReviewType: UILabel!
    @IBOutlet weak var btnStar1     : UIButton!
    @IBOutlet weak var btnStar2     : UIButton!
    @IBOutlet weak var btnStar3     : UIButton!
    @IBOutlet weak var btnStar4     : UIButton!
    @IBOutlet weak var btnStar5     : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblReviewType.font = Fonts.mediumFont13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  KeyMatchingQueTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/30/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class KeyMatchingQueTableViewCell: UITableViewCell {

    @IBOutlet weak var lblQuestion  : UILabel!
    
    @IBOutlet weak var view1        : ShadowView!
    @IBOutlet weak var view2        : ShadowView!
    @IBOutlet weak var view3        : ShadowView!
    
    @IBOutlet weak var btnOption11  : CustomButton!
    @IBOutlet weak var btnOption12  : CustomButton!
    @IBOutlet weak var btnOption21  : CustomButton!
    @IBOutlet weak var btnOption22  : CustomButton!
    @IBOutlet weak var btnOption31  : CustomButton!
    @IBOutlet weak var btnOption32  : CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnOption11.clipsToBounds = true
        btnOption12.clipsToBounds = true
        btnOption21.clipsToBounds = true
        btnOption22.clipsToBounds = true
        btnOption31.clipsToBounds = true
        btnOption32.clipsToBounds = true
        
        lblQuestion.font = Fonts.demi18
        for i in 1...6 {
            let a = self.viewWithTag(i*10000) as! UILabel
            a.font = Fonts.mediumFont13
            let b = self.viewWithTag(i*1000) as! UILabel
            b.font = Fonts.mediumFont13
        }
        
    }

    override func layoutSubviews() {
        view1.cornerRadiusView = (view1.frame.height/2) - 3
        view2.cornerRadiusView = (view2.frame.height/2) - 3
        view3.cornerRadiusView = (view3.frame.height/2) - 3
    }
    
    override func layoutIfNeeded() {
        view1.cornerRadiusView = (view1.frame.height/2) - 3
        view2.cornerRadiusView = (view2.frame.height/2) - 3
        view3.cornerRadiusView = (view3.frame.height/2) - 3
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

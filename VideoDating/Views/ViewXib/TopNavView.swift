//
//  TopNavView.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/25/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class TopNavView: UIView {

    @IBOutlet weak var btnBack          : UIButton!
    @IBOutlet weak var btnBackImage     : UIButton!
    @IBOutlet weak var lblBlessings     : UILabel!
    
    override func layoutSubviews() {
        btnBack.titleLabel?.font        = Fonts.demi18
        lblBlessings.font               = Fonts.mediumFont25
    }
    
}

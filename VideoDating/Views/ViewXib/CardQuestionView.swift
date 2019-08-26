//
//  UIView.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/22/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import  Shuffle_iOS

class CardQuestionView: SwipeCard {

    @IBOutlet weak var lblQuestion  : UILabel!
    @IBOutlet weak var btnChoice1   : CustomButton!
    @IBOutlet weak var btnChoice2   : CustomButton!
    @IBOutlet weak var heightButton : NSLayoutConstraint!
    
    override func awakeFromNib() {
        lblQuestion.font                = Fonts.demi18
        btnChoice1.titleLabel?.font     = Fonts.mediumFont13
        btnChoice2.titleLabel?.font     = Fonts.mediumFont13
        heightButton.constant           = 52*(UIDevice().screenHeight/812)
    }
    
}

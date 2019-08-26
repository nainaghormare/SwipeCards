//
//  QuizTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/30/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    
    @IBOutlet weak var btnForOption3    : CustomButton!
    @IBOutlet weak var btnForOption2    : CustomButton!
    @IBOutlet weak var lblForQuestions  : UILabel!
    @IBOutlet weak var btnForOption1    : CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblForQuestions.font = Fonts.demi18
        btnForOption1.titleLabel?.font = Fonts.mediumFont18
        btnForOption2.titleLabel?.font = Fonts.mediumFont18
        btnForOption3.titleLabel?.font = Fonts.mediumFont18
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

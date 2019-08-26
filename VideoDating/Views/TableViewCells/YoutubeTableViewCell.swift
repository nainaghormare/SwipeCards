//
//  YoutubeTableViewCell.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/19/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class YoutubeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblVideoName : UILabel!
    @IBOutlet weak var lblVideoDesc : UILabel!
    @IBOutlet weak var imgVideo     : UIImageView!
    @IBOutlet weak var btnPlayPause : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblVideoName.font = Fonts.mediumFont13
        lblVideoDesc.font = Fonts.reguFont11
        imgVideo.layer.cornerRadius = 10.0
        imgVideo.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

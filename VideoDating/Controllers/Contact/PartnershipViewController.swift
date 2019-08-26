//
//  ViewController.swift
//  VideoDating
//
//  Created by Kawalpreet Kaur on 7/25/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class PartnershipViewController: BaseViewController {
    
    class func initiateController() -> PartnershipViewController {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "PartnershipViewController") as! PartnershipViewController
        return controller
    }
    
    @IBOutlet weak var viewTop              : UIView!
    @IBOutlet weak var viewBottom           : UIView!
    @IBOutlet weak var viewImg              : UIImageView!
    @IBOutlet weak var lblTitle             : UILabel!
    @IBOutlet weak var lblSubtitle          : UILabel!
    @IBOutlet weak var btnLink              : UIButton!
    
    var isPartnership : Bool                = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDataUI()
        let bottomView    = UINib(nibName: "BottomView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BottomView
        self.viewBottom.addSubview(bottomView)
        self.setupViewXib(innerview: bottomView, outerView: self.viewBottom)
        isPartnership ? bottomView.btnEndorsement.addTarget(self, action: #selector(endorsement), for: .touchUpInside) :  bottomView.btnPartnership.addTarget(self, action: #selector(partnerShip), for: .touchUpInside)
        bottomView.btnContactUS.addTarget(self, action: #selector(contactUs), for: .touchUpInside)
        bottomView.btnContactUS.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnContactUS.titleLabel?.text ?? ""), for: .normal)
        bottomView.btnPartnership.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnPartnership.titleLabel?.text ?? ""), for: .normal)
        bottomView.btnEndorsement.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnEndorsement.titleLabel?.text ?? ""), for: .normal)
        
        let topView    = UINib(nibName: "TopNavView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopNavView
        self.viewTop.addSubview(topView)
        self.setupViewXib(innerview: topView, outerView: self.viewTop)
        let navTitle = isPartnership ? "PARTNERSHIPS" : "ENDORSEMENT"
        topView.btnBack.setTitle(navTitle, for: .normal)
        topView.btnBack.addTarget(self, action: #selector(popFromContact), for: .touchUpInside)
        topView.btnBackImage.addTarget(self, action: #selector(popFromContact), for: .touchUpInside)
        
    }
    
    func changeDataUI() {
        lblTitle.font = Fonts.demi18
        lblSubtitle.font = Fonts.mediumFont13
        if isPartnership {
            viewImg.image = #imageLiteral(resourceName: "partnership")
            lblTitle.text = "Do you have an idea how we can mutually help people find their spouses?"
            lblSubtitle.text = "If so, please send us an email to"
            btnLink.setAttributedTitle(self.getAttributedString(font: Fonts.regu15 ?? UIFont.systemFont(ofSize: 15.0), color: Colors.appOrangeColor, text: "supportnetwork@shidduchview.com"), for: .normal)
        } else {
            viewImg.image = #imageLiteral(resourceName: "endorsement")
            lblTitle.text = "Our goal is to help people find their spouse to build a true Jewish home!"
            lblSubtitle.text = "To see what the Rabbanim write about us, please visit our website at"
            btnLink.setAttributedTitle(self.getAttributedString(font: Fonts.regu15 ?? UIFont.systemFont(ofSize: 15.0), color: Colors.appOrangeColor, text: "www.shidduchview.com"), for: .normal)
        }
    }
    
    @objc func selfPartnerShip() {
        if self.isPartnership != true {
            self.isPartnership = true
            changeDataUI()
        }
        
    }
    
    @objc func selfEndorsement() {
        if self.isPartnership != false {
            self.isPartnership = false
            changeDataUI()
        }
    }

    @IBAction func actionLink(_ sender: Any) {
        
    }
}

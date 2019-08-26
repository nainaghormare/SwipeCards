//
//  ContactUsViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/26/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class ContactUsViewController: BaseViewController {
    
    class func initiateController() -> ContactUsViewController {
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "ContactUsViewController") as! ContactUsViewController
        return controller
    }

    @IBOutlet weak var viewTop      : UIView!
    @IBOutlet weak var viewBottom   : UIView!
    @IBOutlet weak var lblEmail     : UILabel!
    @IBOutlet weak var btnEmail     : UIButton!
    @IBOutlet weak var lblWebsite   : UILabel!
    @IBOutlet weak var btnWebsite   : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        let bottomView    = UINib(nibName: "BottomView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BottomView
        self.viewBottom.addSubview(bottomView)
        self.setupViewXib(innerview: bottomView, outerView: self.viewBottom)
        bottomView.btnEndorsement.addTarget(self, action: #selector(self.endorsement), for: .touchUpInside)
        bottomView.btnPartnership.addTarget(self, action: #selector(self.partnerShip), for: .touchUpInside)
        bottomView.btnContactUS.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnContactUS.titleLabel?.text ?? ""), for: .normal)
        bottomView.btnPartnership.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnPartnership.titleLabel?.text ?? ""), for: .normal)
        bottomView.btnEndorsement.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnEndorsement.titleLabel?.text ?? ""), for: .normal)
        
        let topView    = UINib(nibName: "TopNavView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopNavView
        self.viewTop.addSubview(topView)
        self.setupViewXib(innerview: topView, outerView: self.viewTop)
        topView.btnBack.setTitle("CONTACT US", for: .normal)
        topView.btnBack.addTarget(self, action: #selector(popFromContact), for: .touchUpInside)
        topView.btnBackImage.addTarget(self, action: #selector(popFromContact), for: .touchUpInside)
        
        lblEmail.font = Fonts.mediumFont13
        lblWebsite.font = Fonts.mediumFont13
        btnEmail.setAttributedTitle(self.getAttributedString(font: Fonts.regu15 ?? UIFont.systemFont(ofSize: 15.0), color: Colors.appOrangeColor, text: btnEmail.titleLabel?.text ?? ""), for: .normal)
        btnWebsite.setAttributedTitle(self.getAttributedString(font: Fonts.regu15 ?? UIFont.systemFont(ofSize: 15.0), color: Colors.appOrangeColor, text: btnWebsite.titleLabel?.text ?? ""), for: .normal)
    }
    
    @IBAction func actionWebsiteLink(_ sender: Any) {
        
    }
    
    @IBAction func actionMailLink(_ sender: Any) {
        
    }
    
}

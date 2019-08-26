//
//  ReviewViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/23/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class ReviewViewController: BaseViewController {
    
    class func initiateController() -> ReviewViewController {
        let storyboard  = UIStoryboard(name: "Dashboard", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        return controller
    }

    @IBOutlet weak var tblViewReview    : UITableView!
    @IBOutlet weak var txtFieldNote     : UITextField!
    @IBOutlet weak var lblBlessing      : UILabel!
    @IBOutlet weak var viewBottom       : UIView!
    @IBOutlet weak var btnSubmit        : CustomButton!
    @IBOutlet weak var btnShadchan      : CustomButton!
    @IBOutlet weak var lblQuestion      : UILabel!
    @IBOutlet weak var btnLike          : CustomButton!
    @IBOutlet weak var btnDislike       : CustomButton!
    @IBOutlet weak var lblRateQue       : UILabel!
    @IBOutlet weak var lblAddNotes      : UILabel!
    
    var reviewType = ["Pleasant", "Attractive", "Religious"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        txtFieldNote.font               = Fonts.mediumFont13
        btnSubmit.titleLabel?.font      = Fonts.demi18
        btnShadchan.titleLabel?.font    = Fonts.demi18
        lblQuestion.font                = Fonts.demi18
        btnLike.titleLabel?.font        = Fonts.mediumFont13
        btnDislike.titleLabel?.font     = Fonts.mediumFont13
        lblRateQue.font                 = Fonts.demi18
        lblAddNotes.font                = Fonts.demi18
        lblBlessing.font                = Fonts.mediumFont25
        txtFieldNote.addPaddingLeftIconWithoutImage(padding: 15.0)
        
        let bottomView    = UINib(nibName: "BottomView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BottomView
        self.viewBottom.addSubview(bottomView)
        self.setupViewXib(innerview: bottomView, outerView: self.viewBottom)
        bottomView.btnContactUS.addTarget(self, action: #selector(contactUs), for: .touchUpInside)
        bottomView.btnEndorsement.addTarget(self, action: #selector(self.endorsement), for: .touchUpInside)
        bottomView.btnPartnership.addTarget(self, action: #selector(self.partnerShip), for: .touchUpInside)
        bottomView.btnContactUS.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnContactUS.titleLabel?.text ?? ""), for: .normal)
        bottomView.btnPartnership.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnPartnership.titleLabel?.text ?? ""), for: .normal)
        bottomView.btnEndorsement.setAttributedTitle(self.getAttributedString(font: Fonts.mediumFont10 ?? UIFont.systemFont(ofSize: 10.0), color: Colors.darkPurple, text: bottomView.btnEndorsement.titleLabel?.text ?? ""), for: .normal)
    }
    
    @IBAction func actionSubmit(_ sender: Any) {
        
    }
    
    @IBAction func actionShadchan(_ sender: Any) {
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        for controller in self.navigationController!.viewControllers.reversed() as Array {
            if controller.isKind(of: WaitingViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func option1(_ sender: CustomButton) {
        btnLike.orangeGrad(btn: btnLike)
        btnLike.setTitleColor(.white, for: .normal)
        btnDislike.borderWidth = 1
        btnDislike.borderColorButton = Colors.gradOrangeTop
        btnDislike.setTitleColor(Colors.grayText, for: .normal)
        btnDislike.clearBackground(btn: btnDislike)
    }
    
    @IBAction func option2(_ sender: CustomButton) {
        btnDislike.orangeGrad(btn: btnDislike)
        btnDislike.setTitleColor(.white, for: .normal)
        btnLike.borderWidth = 1
        btnLike.borderColorButton = Colors.gradOrangeTop
        btnLike.setTitleColor(Colors.grayText, for: .normal)
        btnLike.clearBackground(btn: btnLike)
    }
    
    @objc func reviewStar(_ sender: UIButton) {
        let a = sender.tag/100
        for i in (1...a).reversed() {
            let btn = sender.superview?.viewWithTag(i*100) as! UIButton
            btn.isSelected = true
        }
        if a != 5 {
            for i in (a+1)...5 {
                let btn = sender.superview?.viewWithTag(i*100) as! UIButton
                btn.isSelected = false
            }
        }
    }
    
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
        cell.lblReviewType.text = reviewType[indexPath.row]
        cell.btnStar1.addTarget(self, action: #selector(reviewStar), for: .touchUpInside)
        cell.btnStar2.addTarget(self, action: #selector(reviewStar), for: .touchUpInside)
        cell.btnStar3.addTarget(self, action: #selector(reviewStar), for: .touchUpInside)
        cell.btnStar4.addTarget(self, action: #selector(reviewStar), for: .touchUpInside)
        cell.btnStar5.addTarget(self, action: #selector(reviewStar), for: .touchUpInside)
        return cell
    }
    
}

//
//  BlockAccountViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/2/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class BlockAccountViewController: BaseViewController {
    
    class func initiateController() -> BlockAccountViewController {
        let storyboard  = UIStoryboard(name: "SignUp", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "BlockAccountViewController") as! BlockAccountViewController
        return controller
    }

    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblSubtitle      : UILabel!
    @IBOutlet weak var btnLink          : UIButton!
    @IBOutlet weak var btnBack          : UIButton!
    @IBOutlet weak var lblBlessings     : UILabel!
    @IBOutlet weak var imgBottomview    : UIImageView!
    
    var titleText                       = ""
    var subtitle                        = ""
    var btnLinkImage                    = ""
    var imgBottom                       = ""
    var type                            = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBlessings.font   = Fonts.mediumFont25
        lblTitle.font       = Fonts.demi18
        lblSubtitle.font    = Fonts.mediumFont13
        btnLink.setAttributedTitle(self.getAttributedString(font: Fonts.regu15 ?? UIFont.systemFont(ofSize: 15.0), color: Colors.appOrangeColor, text: btnLink.titleLabel?.text ?? ""), for: .normal)
        if type != "" {
            setUpUI()
        }
    }
    
    func setUpUI() {
        self.lblTitle.text = titleText
        self.lblSubtitle.text = subtitle
        self.imgBottomview.image = UIImage(named: imgBottom)
        self.btnLink.setAttributedTitle(NSMutableAttributedString(string: ""), for: .normal)
    }
   
    @IBAction func actionCloase(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: LoginViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func actionLink(_ sender: UIButton) {
        
    }
    
}

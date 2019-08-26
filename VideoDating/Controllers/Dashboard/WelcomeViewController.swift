//
//  WelcomeViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 8/2/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {
    
    class func initiateController() -> WelcomeViewController {
        let storyboard  = UIStoryboard(name: "Dashboard", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        return controller
    }

    @IBOutlet weak var navView          : UIView!
    @IBOutlet weak var tblViewWelcome   : UITableView!
    @IBOutlet weak var btnLetsGo        : CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topView    = UINib(nibName: "TopNavView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopNavView
        self.navView.addSubview(topView)
        self.setupViewXib(innerview: topView, outerView: self.navView)
        topView.btnBack.setTitle("WELCOME!", for: .normal)
        topView.btnBackImage.isHidden = true
        btnLetsGo.titleLabel?.font = Fonts.demi18
    }
    
    @IBAction func actionLetsGo(_ sender: CustomButton) {
        let controller =  WaitingViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension WelcomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverViewTableViewCell", for: indexPath) as! OverViewTableViewCell
            return cell
        }
        if indexPath.row == 1 || indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewPointTableViewCell", for: indexPath) as! OverviewPointTableViewCell
            switch indexPath.row {
            case 1:
                cell.subImgView.image = #imageLiteral(resourceName: "clock")
                cell.lblPoint.text = "At a set time (EST) per day you can go on 1 video speed date for 5 minutes with someone world wide."
            default:
                cell.subImgView.image = #imageLiteral(resourceName: "gift")
                cell.lblPoint.text = "If it's mutual, the next time that both of you are logged in at the same time, you'll have a 10 min date."
            }
            return cell
        }
        if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewSubpointTableViewCell", for: indexPath) as! OverviewSubpointTableViewCell
            switch indexPath.row {
            case 2:
                cell.lblSubpointNumber.text = "1"
                cell.lblSubpoint.text = "You can fill out questions and watch videos until the days Date starts."
            case 3:
                cell.lblSubpointNumber.text = "2"
                cell.lblSubpoint.text = "Your \"blind date\" will be selected by AIM, the Artificial Intelligence Matchmaker and 3,2,1 - Enjoy your 5 min date..."
            default:
                cell.lblSubpointNumber.text = "3"
                cell.lblSubpoint.text = "Review the date and choose if you'd like to go out again."
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 25*(UIDevice().screenHeight/812)
        case 1:
            return 100*(UIDevice().screenHeight/812)
        case 2:
            return 121*(UIDevice().screenHeight/812) - 10
        case 3:
            return 121*(UIDevice().screenHeight/812)
        case 4:
            return 121*(UIDevice().screenHeight/812) - 10
        default:
            return 100*(UIDevice().screenHeight/812)
        }
//        return UITableView.automaticDimension
    }
    
}

class OverViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblOverview : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblOverview.font = Fonts.demi18
    }
    
}

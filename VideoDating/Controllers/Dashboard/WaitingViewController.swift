//
//  WaitingViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/31/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
import SDWebImage
import Koloda
import PopupDialog
import Shuffle_iOS

class WaitingViewController: BaseViewController {
    
    class func initiateController() -> WaitingViewController {
        let storyboard  = UIStoryboard(name: "Dashboard", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "WaitingViewController") as! WaitingViewController
        return controller
    }

    //MARK: IBOutlets and variables
    @IBOutlet weak var navView          : UIView!
    @IBOutlet weak var lblTimer         : UILabel!
    @IBOutlet weak var lblTrainingAI    : UILabel!
    @IBOutlet weak var cardContainerView: SwipeCardStack!
    @IBOutlet weak var cardquestionView : UIView!
    @IBOutlet weak var lblQuestion      : UILabel!
    @IBOutlet weak var btnChoice1       : CustomButton!
    @IBOutlet weak var btnChoice2       : CustomButton!
    @IBOutlet weak var lblYoutubeList   : UILabel!
    @IBOutlet weak var viewYouTubePlyer : YTPlayerView!
    @IBOutlet weak var tblViewVideoList : UITableView!
    @IBOutlet weak var lblTimeZone      : UILabel!
    @IBOutlet weak var lblSun           : UILabel!
    @IBOutlet weak var lbl230time       : UILabel!
    @IBOutlet weak var lblMonday        : UILabel!
    @IBOutlet weak var lbl530tim        : UILabel!
    @IBOutlet weak var lblTuesday       : UILabel!
    @IBOutlet weak var lbl930time       : UILabel!
    @IBOutlet weak var heightButton     : NSLayoutConstraint!
    @IBOutlet weak var heightVideo      : NSLayoutConstraint!
    
    var timer               = Timer()
    var timerDuration: Int  = 7200
    var theTimer            = (h: 0, m: 0, s: 0)
    let playvarsDic         = ["controls": 1, "playsinline": 1, "autohide": 1, "showinfo": 1, "autoplay": 1, "modestbranding": 1, "color": "red"] as [String : Any]
    var youTubeVideos       = [YouTubeVideos]()
    var cardViewQuestions   = [WaitingQuestions]()
    
    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        theTimer            = timerDuration.secondsToHoursMinutesSeconds()
        timer               = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        cardContainerView.dataSource    = self
        cardContainerView.delegate      = self
//        cardContainerView.canDraggableDirection = [.right]
        setupUI()
        getVideoList()
        getWaitingQuestions()
        cardContainerView.numberOfVisibleCards = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let est = TimeUtils.dateToEST(date: Date(), toFormat: DateFormats.yyyy_MM_dd_T_HH_mm_ss_SSSZ)
        print(est ?? "")
        let estStringCurrent = TimeUtils.dateFromString(est, with: DateFormats.yyyy_MM_dd_T_HH_mm_ss_SSSZ) ?? Date()
        let estStringDate = TimeUtils.dateFromString("2019-08-25T02:30:00.583-0400", with: DateFormats.yyyy_MM_dd_T_HH_mm_ss_SSSZ) ?? Date()
        print(estStringDate)
        print(estStringCurrent)
        let diff = estStringDate.timeIntervalSince(estStringCurrent)
        let hours = diff.stringFromTimeInterval()
        print(hours)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tblViewVideoList.flashScrollIndicators()
    }

    //MARK: custom methods
    func setupUI() {
        lblTrainingAI.font              = Fonts.demi18
        lblQuestion.font                = Fonts.demi18
        btnChoice1.titleLabel?.font     = Fonts.mediumFont13
        btnChoice2.titleLabel?.font     = Fonts.mediumFont13
        lblYoutubeList.font             = Fonts.demi18
        lblTimeZone.font                = Fonts.demi18
        lblSun.font                     = Fonts.mediumFont15
        lblMonday.font                  = Fonts.mediumFont15
        lblTuesday.font                 = Fonts.mediumFont15
        lbl530tim.font                  = Fonts.mediumFont13
        lbl230time.font                 = Fonts.mediumFont13
        lbl930time.font                 = Fonts.mediumFont13
        heightButton.constant           = 52*(UIDevice().screenHeight/812)
        heightVideo.constant            = 194*(UIDevice().screenHeight/812)
        
        viewYouTubePlyer.clipsToBounds = true
        viewYouTubePlyer.layer.cornerRadius = 30.0
        
        tblViewVideoList.clipsToBounds = true
        tblViewVideoList.layer.cornerRadius = 30.0
        if #available(iOS 11.0, *) {
            viewYouTubePlyer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            tblViewVideoList.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            viewYouTubePlyer.roundTwoCorners(corners: [.topLeft, .topRight], radius: 15.0)
            tblViewVideoList.roundTwoCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)
        }
    }
    
    func setTimer() {
        
    }
    
    //MARK: @objc methods
    @objc func counter() {
        timerDuration -= 1
        if timerDuration == 0 {
            timer.invalidate()
        } else {
            theTimer            = timerDuration.secondsToHoursMinutesSeconds()
            let displayTimer    = (String(format: "%02d:%02d:%02d", theTimer.h, theTimer.m, theTimer.s))
            lblTimer.text       = displayTimer
        }
    }
    
    @objc func playPauseVideo(sender: UIButton) {
        for i in 0..<youTubeVideos.count {
            self.youTubeVideos[i].isPlayed = (sender.tag == i)
        }
        self.viewYouTubePlyer.load(withVideoId: self.youTubeVideos[sender.tag].videoId ?? "", playerVars: self.playvarsDic)
        self.tblViewVideoList.reloadData()
    }
    
    @objc func optionSel1(sender: CustomButton) {
        sender.orangeGrad(btn: sender)
        sender.setTitleColor(.white, for: .normal)
        cardContainerView.swipe(.right, animated: true)
    }
    
    @objc func optionSel2(sender: CustomButton) {
        sender.orangeGrad(btn: sender)
        sender.setTitleColor(.white, for: .normal)
        cardContainerView.swipe(.right, animated: true)
    }
    
    @IBAction func option1(sender: CustomButton) {
        sender.orangeGrad(btn: sender)
        sender.setTitleColor(.white, for: .normal)
        cardContainerView.swipe(.right, animated: true)
    }
    
    @IBAction func option2(sender: CustomButton) {
        sender.orangeGrad(btn: sender)
        sender.setTitleColor(.white, for: .normal)
        cardContainerView.swipe(.right, animated: true)
    }
    
    //MARK: IBActions
    @IBAction func pushToVideo() {
        cardContainerView.swipe(.right, animated: true)
     }
    
    @IBAction func actionContactUs() {
        let controller = ContactUsViewController.initiateController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func actionPartnerShip(_ sender: UIButton) {
        let controller = PartnershipViewController.initiateController()
        sender.tag == 100 ? (controller.isPartnership = true) : (controller.isPartnership = false)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func actionLogout(_ sender: UIButton) {
        let controller                              =  AlertViewController.initiateController()
        controller.alertImage                       = #imageLiteral(resourceName: "backAlert")
        controller.alertTitleString                 = "Are you sure you want to logout?"
        controller.alertSubtitleString              = ""
        controller.isReg                            = false
        controller.navigationItem.hidesBackButton   = false
        let popupDialog  = PopupDialog(viewController: controller,
                                       buttonAlignment: .horizontal,
                                       transitionStyle: .bounceDown,
                                       tapGestureDismissal: true,
                                       panGestureDismissal: false)
        self.present(popupDialog, animated: false, completion: nil)
        controller.dismissVCCompletion { str in
            if str == "Yes" {
                AppInstance.shared.kUserDefault.removeObject(forKey: Macros.userDetails)
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
}

extension WaitingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return youTubeVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YoutubeTableViewCell", for: indexPath) as! YoutubeTableViewCell
        let showImage                     = youTubeVideos[indexPath.row].thumbnail_url ?? ""
        cell.imgVideo.sd_imageIndicator   = SDWebImageActivityIndicator.gray
        cell.imgVideo.sd_setImage(with: URL(string: showImage)) { (image, error, type, url) in
            if error != nil {
                cell.imgVideo.image       = UIImage(named: "youtubeThmbnail")
            }
        }
        cell.lblVideoName.text = youTubeVideos[indexPath.row].title
        cell.lblVideoDesc.text = youTubeVideos[indexPath.row].subtitle
        cell.btnPlayPause.tag = indexPath.row
        youTubeVideos[indexPath.row].isPlayed ?? false ? cell.btnPlayPause.setImage(UIImage(named: "pause"), for: .normal) :cell.btnPlayPause.setImage(UIImage(named: "play"), for: .normal)
        cell.btnPlayPause.addTarget(self, action: #selector(playPauseVideo), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<youTubeVideos.count {
            self.youTubeVideos[i].isPlayed = (indexPath.row == i)
        }
        self.viewYouTubePlyer.load(withVideoId: self.youTubeVideos[indexPath.row].videoId ?? "", playerVars: self.playvarsDic)
        self.tblViewVideoList.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalIndicator = scrollView.subviews.last as? UIImageView
        verticalIndicator?.backgroundColor = Colors.darkPurple
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0  
    }
    
}

extension WaitingViewController: SwipeCardStackDelegate, SwipeCardStackDataSource {
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return self.cardViewQuestions.count
    }
    
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        let questionView    = UINib(nibName: "CardQuestionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CardQuestionView
        self.cardContainerView.addSubview(questionView)
        questionView.translatesAutoresizingMaskIntoConstraints = false
        self.cardContainerView.addConstraint(NSLayoutConstraint(item: questionView, attribute: .trailing, relatedBy: .equal, toItem: self.cardContainerView, attribute: .trailing, multiplier: 1, constant: 0))
        self.cardContainerView.addConstraint(NSLayoutConstraint(item: questionView, attribute: .leading, relatedBy: .equal, toItem: self.cardContainerView, attribute: .leading, multiplier: 1, constant: 0))
        self.cardContainerView.addConstraint(NSLayoutConstraint(item: questionView, attribute: .top, relatedBy: .equal, toItem: self.cardContainerView, attribute: .top, multiplier: 1, constant: 0))
        self.cardContainerView.addConstraint(NSLayoutConstraint(item: questionView, attribute: .bottom, relatedBy: .equal, toItem: self.cardContainerView, attribute: .bottom, multiplier: 1, constant: 0))
        questionView.lblQuestion.text = self.cardViewQuestions[index].questions
        questionView.btnChoice1.setTitle(self.cardViewQuestions[index].option1, for: .normal)
        questionView.btnChoice2.setTitle(self.cardViewQuestions[index].option2, for: .normal)
        questionView.btnChoice1.addTarget(self, action: #selector(optionSel1(sender:)), for: .touchUpInside)
        questionView.btnChoice2.addTarget(self, action: #selector(optionSel2(sender:)), for: .touchUpInside)
        return questionView
    }
    
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        self.getWaitingQuestions()
    }
    
}

//API Calls
extension WaitingViewController {
    
    func getVideoList() {
        let service = WaitingServices()
        service.getYoutubeVideoList(with: self, complition: { response in
                if let video = response {
                    self.youTubeVideos = video
                    self.viewYouTubePlyer.load(withVideoId: self.youTubeVideos[0].videoId ?? "", playerVars: self.playvarsDic)
                    self.youTubeVideos[0].isPlayed = true
                    self.tblViewVideoList.reloadData()
            }
        })
    }
    
    func getWaitingQuestions() {
        let service = WaitingServices()
        service.getWaitingQuestions(with: self, complition: { response in
            if let questions = response {
                self.cardViewQuestions = questions
                self.cardContainerView.reloadData()
//                self.cardContainerView.reload()
            }
        })
    }
    
}

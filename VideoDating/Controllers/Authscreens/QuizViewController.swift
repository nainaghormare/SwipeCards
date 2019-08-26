//
//  QuizViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/30/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class QuizViewController: BaseViewController {
    
    class func initiateController() -> QuizViewController {
        let storyboard  = UIStoryboard(name: "SignUp", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
        return controller
    }
    
    @IBOutlet weak var tblForQuestions      : UITableView!
    @IBOutlet weak var btnToSubmit          : CustomButton!
    @IBOutlet weak var viewForTerms         : UIView!
    @IBOutlet weak var viewForTop           : UIView!
    @IBOutlet weak var btnTermsCondi        : UIButton!
    @IBOutlet weak var btnTermsCondiPage    : UIButton!
    
    var bibleQues   = [BibleQuestions]()
    var arrQueId    = ["", "", ""]
    var arrQue      = ["", "", ""]
    var arrAnsId    = ["", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblForQuestions.tableFooterView = viewForTerms
        let topView    = UINib(nibName: "TopNavView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopNavView
        self.viewForTop.addSubview(topView)
        self.setupViewXib(innerview: topView, outerView: self.viewForTop)
        topView.btnBack.setTitle("ANSWER THE QUIZ", for: .normal)
        topView.btnBack.addTarget(self, action: #selector(regBackBtnAction), for: .touchUpInside)
        topView.btnBackImage.addTarget(self, action: #selector(regBackBtnAction), for: .touchUpInside)
        let attributedText = NSMutableAttributedString(string: "Agree with ", attributes: [NSAttributedString.Key.font: Fonts.demi12 ?? UIFont.systemFont(ofSize: 12.0), NSAttributedString.Key.foregroundColor: Colors.grayText])
        attributedText.append(self.getAttributedString(font: Fonts.demi12 ?? UIFont.systemFont(ofSize: 12.0), color: Colors.appOrangeColor, text: "Terms and conditions"))
        btnTermsCondiPage.setAttributedTitle(attributedText, for: .normal)
        getBibleQuestion()
    }
    
    @IBAction func actionToSubmit(_ sender: Any) {
        let valid = self.arrAnsId.filter({$0 == ""})
        if valid.count > 0 {
            self.okAlert(msg: "Please provide all answers.")
        } else if btnTermsCondi.image(for: .normal) == UIImage(named: "checkbox") {
            self.okAlert(msg: "Please agree Terms and conditions.")
        } else {
            self.saveAnswers()
        }
    }
    
    @IBAction func actionForTerms(sender: UIButton) {
        let controller                              = TermsConditionViewController.initiateController()
        navigationController?.addChild(controller)
        controller.navigationItem.hidesBackButton   = true
        controller.view?.frame                      = (navigationController?.view?.frame)!
        navigationController?.view.addSubview((controller.view)!)
        controller.dismissVCCompletion { _ in
            print("Dismissed")
        }
    }
    
    @IBAction func actionForTermsSelected(sender: UIButton) {
        sender.image(for: .normal) == UIImage(named: "checked") ? sender.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal) : sender.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
    }
    
    @objc func actionOption(sender: UIButton) {
        sender.isSelected = true
        switch sender.tag {
        case 100:
            let btn1 = sender.superview?.viewWithTag(200) as! CustomButton
            let btn2 = sender.superview?.viewWithTag(300) as! CustomButton
            btn1.isSelected = false
            btn2.isSelected = false
            switch sender.title(for: .normal) {
            case "3":
                self.arrAnsId[0] = sender.title(for: .normal) ?? ""
            case "12":
                self.arrAnsId[1] = sender.title(for: .normal) ?? ""
            default:
                self.arrAnsId[2] = sender.title(for: .normal) ?? ""
            }
        case 200:
            let btn1 = sender.superview?.viewWithTag(100) as! CustomButton
            let btn2 = sender.superview?.viewWithTag(300) as! CustomButton
            btn1.isSelected = false
            btn2.isSelected = false
            switch sender.title(for: .normal) {
            case "2":
                self.arrAnsId[0] = sender.title(for: .normal) ?? ""
            case "16":
                self.arrAnsId[1] = sender.title(for: .normal) ?? ""
            default:
                self.arrAnsId[2] = sender.title(for: .normal) ?? ""
            }
        default:
            let btn1 = sender.superview?.viewWithTag(100) as! CustomButton
            let btn2 = sender.superview?.viewWithTag(200) as! CustomButton
            btn1.isSelected = false
            btn2.isSelected = false
            switch sender.title(for: .normal) {
            case "4":
                self.arrAnsId[0] = sender.title(for: .normal) ?? ""
            case "7":
                self.arrAnsId[1] = sender.title(for: .normal) ?? ""
            default:
                self.arrAnsId[2] = sender.title(for: .normal) ?? ""
            }
        }
        self.tblForQuestions.reloadData()
    }
    
    func getBibleQuestion() {
        let service = UserService()
        service.gettheBibleQuestions(with: self, complition: { response in
            if let questions = response {
                self.bibleQues = questions
                for i in 0..<questions.count {
                    switch questions[i].questions {
                    case "How many Avos are there?":
                        self.arrQueId[0]    = questions[i]._id ?? ""
                        self.arrQue[0]      = questions[i].questions ?? ""
                    case "How many Sh'vatim are there?":
                        self.arrQueId[1]    = questions[i]._id ?? ""
                        self.arrQue[1]      = questions[i].questions ?? ""
                    default:
                        self.arrQueId[2]    = questions[i]._id ?? ""
                        self.arrQue[2]      = questions[i].questions ?? ""
                    }
                    self.tblForQuestions.reloadData()
                }
            }
        })
    }
    
    func saveAnswers() {
        let service                     = UserService()
        var selectedAns                 : [Dictionary<String, String>]  = []
        var que                         = Dictionary<String, String>()
        for index in (self.arrQueId.enumerated()) {
            que[ApiKeys.kQ_id]          = self.arrQueId[index.offset]
            que[ApiKeys.kQuestions]     = self.arrQue[index.offset]
            que[ApiKeys.kAnswer_text]   = self.arrAnsId[index.offset]
            selectedAns.append(que)
        }
        service.savetheBibleQuestions(with: AppInstance.shared.user?._id ?? "", answer: selectedAns, target: self, complition: { response in
            if let user = response {
                AppInstance.shared.user = user
                AppInstance.shared.kUserDefault.setValue(AppInstance.shared.user?.dictionaryRepresentation(), forKey: Macros.userDetails)
                if user.isBlocked ?? false {
                    let controller = BlockAccountViewController.initiateController()
                    self.navigationController?.pushViewController(controller, animated: true)
                } else {
                    let controller = WaitingViewController.initiateController()
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        })
    }
    
}


extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bibleQues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizTableViewCell", for: indexPath) as! QuizTableViewCell
        cell.lblForQuestions.text = bibleQues[indexPath.row].questions
        
        cell.btnForOption1.setTitle(bibleQues[indexPath.row].option1, for: .normal)
        cell.btnForOption2.setTitle(bibleQues[indexPath.row].option2, for: .normal)
        cell.btnForOption3.setTitle(bibleQues[indexPath.row].option3, for: .normal)
        
        cell.btnForOption1.addTarget(self, action: #selector(actionOption), for: .touchUpInside)
        cell.btnForOption2.addTarget(self, action: #selector(actionOption), for: .touchUpInside)
        cell.btnForOption3.addTarget(self, action: #selector(actionOption), for: .touchUpInside)
        
        if cell.btnForOption1.isSelected {
            cell.btnForOption1.orangeGrad(btn: cell.btnForOption1)
        } else {
            cell.btnForOption1.clearBackground(btn: cell.btnForOption1)
        }
        
        if cell.btnForOption2.isSelected {
            cell.btnForOption2.orangeGrad(btn: cell.btnForOption2)
        } else {
            cell.btnForOption2.clearBackground(btn: cell.btnForOption2)
        }
        
        if cell.btnForOption3.isSelected {
            cell.btnForOption3.orangeGrad(btn: cell.btnForOption3)
        } else {
            cell.btnForOption3.clearBackground(btn: cell.btnForOption3)
        }
        
        return cell
    }
    
    
}

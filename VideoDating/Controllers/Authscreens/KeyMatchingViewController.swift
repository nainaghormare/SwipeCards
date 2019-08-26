//
//  KeyMatchingViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/30/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit

class KeyMatchingViewController: BaseViewController {
    
    class func initiateController() -> KeyMatchingViewController {
        let storyboard  = UIStoryboard(name: "SignUp", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "KeyMatchingViewController") as! KeyMatchingViewController
        return controller
    }

    @IBOutlet weak var navView              : UIView!
    @IBOutlet weak var tblViewKeyMatching   : UITableView!
    @IBOutlet weak var btnNext              : CustomButton!
    
    var isFemale    : Bool                  = true
    var selectedKey                         = [false, false, false, false, false, false]
    var isCohen     : Bool                  = false
    var superImpQuestions                   = [SuperImpQuestions]()
    var arrQueId                            = ["", "", "", ""]
    var arrQue                              = ["", "", "", ""]
    var arrAnsId                            = ["", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topView    = UINib(nibName: "TopNavView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopNavView
        self.navView.addSubview(topView)
        self.setupViewXib(innerview: topView, outerView: self.navView)
        topView.btnBack.setTitle("KEY MATCHING QUESTIONS", for: .normal)
        topView.btnBack.addTarget(self, action: #selector(regBackBtnAction), for: .touchUpInside)
        topView.btnBackImage.addTarget(self, action: #selector(regBackBtnAction), for: .touchUpInside)
        btnNext.titleLabel?.font = Fonts.demi18
        getQuestions()
    }
    
    override func viewDidLayoutSubviews() {
        self.tblViewKeyMatching.reloadData()
    }
    
    @IBAction func actionNext(_ sender: Any) {
        let valid = self.arrAnsId.filter({$0 == ""})
        if valid.count > 0 {
            self.okAlert(msg: "Please answer all the questions.")
        } else {
            self.saveAnswers()
        }
    }
    
    @objc func actionKeyMatchSelection(sender: UIButton) {
        switch sender.tag {
        case 0:
            if selectedKey[sender.tag] == true {
                break
            } else {
                selectedKey[sender.tag] = true
                self.arrAnsId[0] = "Married woman covering hair"
                selectedKey[sender.tag + 1] = false
            }
        case 1:
            if selectedKey[sender.tag] == true {
                break
            } else {
                selectedKey[sender.tag] = true
                self.arrAnsId[0] = "Baseball caps are fine"
                selectedKey[sender.tag - 1] = false
            }
        case 2:
            if selectedKey[sender.tag] == true {
                break
            } else {
                selectedKey[sender.tag] = true
                self.arrAnsId[1] = "Woman only wearing skirts"
                selectedKey[sender.tag + 1] = false
            }
        case 3:
            if selectedKey[sender.tag] == true {
                break
            } else {
                selectedKey[sender.tag] = true
                self.arrAnsId[1] = "Pants are fine"
                selectedKey[sender.tag - 1] = false
            }
        case 4:
            if selectedKey[sender.tag] == true {
                break
            } else {
                selectedKey[sender.tag] = true
                self.arrAnsId[2] = "Shomer Nageah"
                selectedKey[sender.tag + 1] = false
            }
        default:
            if selectedKey[sender.tag] == true {
                break
            } else {
                selectedKey[sender.tag] = true
                self.arrAnsId[2] = "Hugs are ok"
                selectedKey[sender.tag - 1] = false
            }
        }
        self.tblViewKeyMatching.reloadData()
    }
    
    @objc func actionCohen(sender: UIButton) {
        isCohen = sender.tag == 100
        self.arrAnsId[3] = sender.tag == 100 ? "Yes" : "No"
        self.tblViewKeyMatching.reloadData()
    }
    
    func getQuestions() {
        let service = UserService()
        service.getSuperImportantQuestions(with: AppInstance.shared.user?._id ?? "", target: self, complition: { response in
            if let questions = response {
                self.superImpQuestions = questions
                for i in 0..<questions.count {
                    switch questions[i].option1 {
                    case "Married woman covering hair", "Baseball caps are fine":
                        self.arrQueId[0] = questions[i]._id ?? ""
                        self.arrQue[0] = questions[i].questions ?? ""
                    case "Woman only wearing skirts", "Pants are fine":
                        self.arrQueId[1] = questions[i]._id ?? ""
                        self.arrQue[1] = questions[i].questions ?? ""
                    case "Shomer Nageah", "Hugs are ok":
                        self.arrQueId[2] = questions[i]._id ?? ""
                        self.arrQue[2] = questions[i].questions ?? ""
                    default:
                        self.arrQue[3] = questions[i]._id ?? ""
                        self.arrQue[3] = questions[i].questions ?? ""
                    }
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
        service.saveSuperImportantQuestions(with: AppInstance.shared.user?._id ?? "", answer: selectedAns, target: self, complition: { response in
            if  response == " updated successfully."{
                AppInstance.shared.user?.isNormalQuizComplete = true
                AppInstance.shared.kUserDefault.setValue(AppInstance.shared.user?.dictionaryRepresentation(), forKey: Macros.userDetails)
                let controller = QuizViewController.initiateController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
        })
    }
    
}

extension KeyMatchingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "KeyMatchingQueTableViewCell", for: indexPath) as! KeyMatchingQueTableViewCell
            cell.btnOption11.tag = 0
            cell.btnOption12.tag = 1
            cell.btnOption21.tag = 2
            cell.btnOption22.tag = 3
            cell.btnOption31.tag = 4
            cell.btnOption32.tag = 5
            
            cell.btnOption11.addTarget(self, action: #selector(actionKeyMatchSelection), for: .touchUpInside)
            cell.btnOption12.addTarget(self, action: #selector(actionKeyMatchSelection), for: .touchUpInside)
            cell.btnOption21.addTarget(self, action: #selector(actionKeyMatchSelection), for: .touchUpInside)
            cell.btnOption22.addTarget(self, action: #selector(actionKeyMatchSelection), for: .touchUpInside)
            cell.btnOption31.addTarget(self, action: #selector(actionKeyMatchSelection), for: .touchUpInside)
            cell.btnOption32.addTarget(self, action: #selector(actionKeyMatchSelection), for: .touchUpInside)
            
            cell.view1.cornerRadiusView = (cell.view1.frame.height/2) - 3
            cell.view2.cornerRadiusView = (cell.view2.frame.height/2) - 3
            cell.view3.cornerRadiusView = (cell.view3.frame.height/2) - 3
            
            for i in 0..<selectedKey.count {
                if selectedKey[i] == true {
                    let label = cell.viewWithTag((i+1) * 1000) as! UILabel
                    let nLabel = cell.viewWithTag((i+1) * 10000) as! UILabel
                    switch i {
                    case 0:
                        cell.btnOption11.orangeGrad(btn: cell.btnOption11)
                    case 1:
                        cell.btnOption12.orangeGrad(btn: cell.btnOption12)
                    case 2:
                        cell.btnOption21.orangeGrad(btn: cell.btnOption21)
                    case 3:
                        cell.btnOption22.orangeGrad(btn: cell.btnOption22)
                    case 4:
                        cell.btnOption31.orangeGrad(btn: cell.btnOption31)
                    default:
                        cell.btnOption32.orangeGrad(btn: cell.btnOption32)
                    }
                    label.textColor = .white
                    nLabel.textColor = .white
                } else {
                    let label = cell.viewWithTag((i+1) * 1000) as! UILabel
                    let nLabel = cell.viewWithTag((i+1) * 10000) as! UILabel
                    switch i {
                    case 0:
                        cell.btnOption11.clearBackground(btn: cell.btnOption11)
                    case 1:
                        cell.btnOption12.clearBackground(btn: cell.btnOption12)
                    case 2:
                        cell.btnOption21.clearBackground(btn: cell.btnOption21)
                    case 3:
                        cell.btnOption22.clearBackground(btn: cell.btnOption22)
                    case 4:
                        cell.btnOption31.clearBackground(btn: cell.btnOption31)
                    default:
                        cell.btnOption32.clearBackground(btn: cell.btnOption32)
                    }
                    label.textColor = Colors.grayText
                    nLabel.textColor = Colors.grayText
                }
            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CohenTableViewCell", for: indexPath) as! CohenTableViewCell
            cell.btnYes.tag = 100
            cell.btnNo.tag = 200
            cell.btnNo.addTarget(self, action: #selector(actionCohen), for: .touchUpInside)
            cell.btnYes.addTarget(self, action: #selector(actionCohen), for: .touchUpInside)
            cell.lblCohenQue.text =  (AppInstance.shared.user?.gender == 1) ? "Are you able to marry a Cohen?" : "Are you a Cohen?"

            cell.btnNo.cornerRadiusValue     = cell.btnNo.frame.height/2
            cell.btnYes.cornerRadiusValue    = cell.btnYes.frame.height/2
            if isCohen {
                cell.btnYes.orangeGrad(btn: cell.btnYes)
                cell.btnYes.setTitleColor(.white, for: .normal)
                cell.btnNo.borderWidth = 1
                cell.btnNo.borderColorButton = Colors.gradOrangeTop
                cell.btnNo.setTitleColor(Colors.grayText, for: .normal)
                cell.btnNo.clearBackground(btn: cell.btnNo)
            } else if self.arrAnsId[3] != "" {
                cell.btnNo.orangeGrad(btn: cell.btnNo)
                cell.btnNo.setTitleColor(.white, for: .normal)
                cell.btnYes.borderWidth = 1
                cell.btnYes.borderColorButton = Colors.gradOrangeTop
                cell.btnYes.setTitleColor(Colors.grayText, for: .normal)
                cell.btnYes.clearBackground(btn: cell.btnYes)
            }
            cell.layoutIfNeeded()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

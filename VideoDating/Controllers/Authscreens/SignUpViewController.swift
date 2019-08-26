//
//  SignUpViewController.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/29/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import DropDown

class SignUpViewController: BaseViewController {
    
    class func initiateController() -> SignUpViewController {
        let storyboard  = UIStoryboard(name: "SignUp", bundle: nil)
        let controller  = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return controller
    }

    @IBOutlet weak var topView              : UIView!
    @IBOutlet weak var tblViewSignUp        : UITableView!
    @IBOutlet weak var tblHeightConstraint  : NSLayoutConstraint!
    
    var dropDown                            = DropDown()
    var arrValues                           = ["", "Male", "01", "01", "1960", "", "", ""]
    let dataWithValue                       = ["Name", "Gender", "Date Of Birth", "Date Of Birth", "Date Of Birth", "Email", "Password", "Confirm Password", "valid email", "Password and confirm password not matched.", "valid date of birth"]
    var securedValues                       =  [true, true]
    var arrForValidation                    = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let topView    = UINib(nibName: "TopNavView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopNavView
        self.topView.addSubview(topView)
        self.setupViewXib(innerview: topView, outerView: self.topView)
        topView.btnBack.setTitle("SIGN UP", for: .normal)
        topView.btnBack.addTarget(self, action: #selector(regBackBtnAction), for: .touchUpInside)
        topView.btnBackImage.addTarget(self, action: #selector(regBackBtnAction), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tblHeightConstraint.constant = tblViewSignUp.contentSize.height + 50
    }
    
    @IBAction func actionNext(_ sender: UIButton) {
        var isValid = false
        arrForValidation.removeAll()
        var arrForValidation = [Int]()
        if arrValues.count > 0 {
            for index in 0..<arrValues.count {
                let value = arrValues[index]
                if index == 0 {
                    if value == "" {
                        isValid = false
                        arrForValidation.append(index)
                        break
                    }
                } else if value == "" || value.trimSpaces().count == 0 {
                    isValid = false
                    arrForValidation.append(index)
                    break
                }
                if index == 5 {
                    if !self.isValidEmail(emailStr: value) {
                        isValid = false
                        arrForValidation.append(8)
                    }
                }
                if index == 7 {
                    if arrValues[6] != value {
                        isValid = false
                        arrForValidation.append(9)
                    }
                } else if (value.trimSpaces().count) > 0 {
                    isValid = true
                }
                if arrValues[2] == "01" && arrValues[3] == "01" && arrValues[4] == "1960" {
                    isValid = false
                    arrForValidation.append(10)
                }
            }
        }else{
            isValid = false
            arrForValidation.append(0)
        }
        if isValid {
            self.signUpApi()
        } else {
            self.tblViewSignUp.reloadData()
            if [arrForValidation[0]].contains(9) {
                self.okAlert(msg: "\(dataWithValue[arrForValidation[0]])")
            } else {
                self.okAlert(msg: "Please enter \(dataWithValue[arrForValidation[0]])")
            }
        }
    
    }
    
    @objc func dropDownAction(sender: UIButton) {
        dropDown.anchorView                 = sender
        dropDown.bottomOffset               = CGPoint(x: 0, y: sender.bounds.height)
        dropDown.offsetFromWindowBottom     = 150
        dropDown.direction                  = .bottom
        dropDown.shadowColor                = Colors.shadowColor
        dropDown.shadowRadius               = 30.0
        dropDown.cornerRadius               = 15.0
        dropDown.backgroundColor            = .white
        if sender.tag != 100 {
            dropDown.customCellConfiguration    = { (index: Index, item: String, cell: DropDownCell) -> Void in
                cell.optionLabel.textAlignment  = .center
            }
        }
        dropDown.textColor                  = Colors.grayText
        
        switch sender.tag {
        case 100:
            dropDown.dataSource             = ["Female", "Male"]
        case 200:
            dropDown.dataSource             = (01...31).map { String($0) }
        case 300:
            dropDown.dataSource             = (01...12).map { String($0) }
        default:
            dropDown.dataSource             = (1960...2000).map { String($0) }
        }
        dropDown.selectionAction            = { [weak self] (index, item) in
            let value                       = self?.dropDown.dataSource[index] ?? ""
            switch sender.tag {
            case 100:
                self?.arrValues[1] = value
            case 200:
                self?.arrValues[2] = value
            case 300:
                self?.arrValues[3] = value
            default:
                self?.arrValues[4] = value
            }
            self?.tblViewSignUp.reloadData()
        }
        dropDown.show()
    }
    
    @objc func pwdSetting(sender: UIButton) {
        switch sender.tag {
        case 500:
            securedValues[0] == true ? sender.setImage(#imageLiteral(resourceName: "eye"), for: .normal) : sender.setImage(#imageLiteral(resourceName: "hiddenEye"), for: .normal)
            securedValues[0] = !securedValues[0]
        default:
            securedValues[1] == true ? sender.setImage(#imageLiteral(resourceName: "eye"), for: .normal) : sender.setImage(#imageLiteral(resourceName: "hiddenEye"), for: .normal)
            securedValues[1] = !securedValues[1]
        }
        self.tblViewSignUp.reloadData()
    }
    
    func addValueToArray(value:String, index: Int) {
        if arrValues.count <= index{
            for _ in arrValues.count...index{
                arrValues.append("")
            }
        }
        arrValues[index] = value
    }
    
    func signUpApi() {
        let service = UserService()
        let gender = arrValues[1] == "Male" ? 0 : 1
        let dob = arrValues[2] + "/" + arrValues[3] + "/" + arrValues[4]
        service.signUp(with: arrValues[0], lastName: "", email: arrValues[5], gender: gender, DOB: dob, loginType: 0, facebookSocialId: "", googleSocialId: "", password: arrValues[6], target: self, complition: { response in
            if let user = response {
                AppInstance.shared.user = user
                AppInstance.shared.kUserDefault.setValue(AppInstance.shared.user?.dictionaryRepresentation(), forKey: Macros.userDetails)
                let controller = KeyMatchingViewController.initiateController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
        })
    }
    
}

extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GenderTableViewCell", for: indexPath) as! GenderTableViewCell
            cell.txtFieldGender.text = self.arrValues[1]
            cell.btnGender.tag = 100
            cell.btnGender.addTarget(self, action: #selector(dropDownAction), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DOBTableViewCell", for: indexPath) as! DOBTableViewCell
            cell.btnDate.tag = 200
            cell.btnMonth.tag = 300
            cell.btnYear.tag = 400
            
            cell.btnDate.addTarget(self, action: #selector(dropDownAction), for: .touchUpInside)
            cell.btnMonth.addTarget(self, action: #selector(dropDownAction), for: .touchUpInside)
            cell.btnYear.addTarget(self, action: #selector(dropDownAction), for: .touchUpInside)
            
            cell.lblDate.text = self.arrValues[2]
            cell.lblMonth.text = self.arrValues[3]
            cell.lblYear.text = self.arrValues[4]
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailPwdTableViewCell", for: indexPath) as! EmailPwdTableViewCell
            cell.btnPwdImage.isHidden = true
            cell.lblemailPwd.text = "Email"
            cell.txtFieldEmailPwd.tag = 5
            cell.txtFieldEmailPwd.keyboardType = .emailAddress
            cell.txtFieldEmailPwd.isSecureTextEntry = false
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailPwdTableViewCell", for: indexPath) as! EmailPwdTableViewCell
            cell.btnPwdImage.tag = 500
            cell.btnPwdImage.addTarget(self, action: #selector(pwdSetting), for: .touchUpInside)
            cell.lblemailPwd.text = "Password"
            cell.txtFieldEmailPwd.tag = 6
            cell.txtFieldEmailPwd.isSecureTextEntry = self.securedValues[0]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmailPwdTableViewCell", for: indexPath) as! EmailPwdTableViewCell
            cell.btnPwdImage.tag = 600
            cell.btnPwdImage.addTarget(self, action: #selector(pwdSetting), for: .touchUpInside)
            cell.lblemailPwd.text = "Confirm Password"
            cell.txtFieldEmailPwd.tag = 7
            cell.txtFieldEmailPwd.isSecureTextEntry = self.securedValues[1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString               = currentString.replacingCharacters(in: range, with: string) as String
        switch textField.tag {
        case 0:
            let alphabetsOnly       = NSCharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")
            let stringFromTextField = NSCharacterSet.init(charactersIn: string)
            let strValid            = alphabetsOnly.isSuperset(of: stringFromTextField as CharacterSet)
            addValueToArray(value: newString as String, index: textField.tag)
            return strValid
        case 5:
            let alphabetsOnly       = NSCharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.")
            let stringFromTextField = NSCharacterSet.init(charactersIn: string)
            let strValid            = alphabetsOnly.isSuperset(of: stringFromTextField as CharacterSet)
            addValueToArray(value: newString as String, index: textField.tag)
            return strValid
        case 6,7:
            let alphabetsOnly       = NSCharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@!#$%^&*()_-")
            let stringFromTextField = NSCharacterSet.init(charactersIn: string)
            let strValid            = alphabetsOnly.isSuperset(of: stringFromTextField as CharacterSet)
            addValueToArray(value: newString as String, index: textField.tag)
            return strValid
        case 1:
            return false
        default:
            addValueToArray(value: newString as String, index: textField.tag)
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

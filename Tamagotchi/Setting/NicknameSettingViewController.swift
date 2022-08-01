//
//  NicknameSettingViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/24.
//

import UIKit

class NicknameSettingViewController: UIViewController {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var whiteLineImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designNaviagtion()
        designTextField()
   
    }
    
    func designNaviagtion(){
        view.backgroundColor = .systemGray2
        title = "유저 이름 설정"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    func designTextField(){
        userTextField.backgroundColor = .clear
        userTextField.borderStyle = .none
        whiteLineImageView.image = UIImage(named: "horizontalWhiteLine")
        whiteLineImageView.contentMode = .scaleToFill
        
        userTextField.placeholder = "\(UserDefaultsHelper.standard.userNickname)님 닉네임을 입력해주세요!"
    }
    
    func textFieldShouldReturn(_ TextField: UITextField) -> Bool {
        
        
        userTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        self.view.endEditing(true)

        return true
        
    }
    
    @objc func saveButtonTapped(){
        guard let nickname = userTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !nickname.isEmpty, (2...6).contains(nickname.count) else {
            alert(title: "!", message: "닉네임은 2~6자로 제한됩니다.")
            return
        }
        guard let nickname = userTextField.text else {return}
        UserDefaultsHelper.standard.userNickname = nickname
        let settingStoryBoard = UIStoryboard(name: "Setting", bundle: nil)
        let settingViewController = settingStoryBoard.instantiateViewController(withIdentifier: SettingTableViewController.reuseIdentifier) as! SettingTableViewController
        settingViewController.refresh()
        self.navigationController?.popViewController(animated: true)
    }
 
    @IBAction func doneUserTextField(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
}

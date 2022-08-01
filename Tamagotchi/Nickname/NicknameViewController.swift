//
//  NicknameViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

class NicknameViewController: UIViewController {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var userNicknameTextField: UITextField!
    @IBOutlet weak var mainUIView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet var labelOutletCollection: [UILabel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        designLabel()
        designDoneButton()
        designMainUIView()
        UserDefaults.standard.set(true, forKey: "First")
    }
    
    func requestAuthorization(){
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .badge, .sound, .alert)
        
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
    }
    
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.sound = .default
        notificationContent.title = "다마고치를 키워보세요."
        notificationContent.subtitle = "밥이나 물을 줘볼까요?"
        notificationContent.body = "따끔이, 방실이, 반짝이가 배고파해요."
        notificationContent.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
//        var dateComponents = DateComponents()
//        dateComponents.minute = 1
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "1", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request)
        
    }

    func designMainUIView(){
        mainUIView.clipsToBounds = true
        mainUIView.layer.cornerRadius = 10
    }
    
    func designLabel(){
        for tag in 0...labelOutletCollection.count - 1{
            labelOutletCollection[tag].textColor = .white
            labelOutletCollection[tag].textAlignment = .center
            labelOutletCollection[tag].font = .systemFont(ofSize: 15)
        }
        labelOutletCollection[2].text = "닉네임을 설정해주세요!"
        labelOutletCollection[1].text = "2~6글자. 공백 불가"
        labelOutletCollection[1].font = .systemFont(ofSize: 13)
        labelOutletCollection[1].textColor = .systemGray2
    }
    
    func designDoneButton(){
        doneButton.tintColor = .white
        doneButton.setTitle("결정", for: .normal)
        doneButton.backgroundColor = .black
        doneButton.layer.cornerRadius = 8
    }
    
    func textFieldShouldReturn(_ TextField: UITextField) -> Bool {
        
        
        userNicknameTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
        self.view.endEditing(true)

        return true
        
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
       
        guard let nickname = userNicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !nickname.isEmpty, (2...6).contains(nickname.count) else {
            alert(title: "!", message: "닉네임은 2~6자로 제한됩니다.")
            return
        }
        
        
        let choiceStoryBoard = UIStoryboard(name: "Choice", bundle: nil)
        guard let choiceCollectionViewController = choiceStoryBoard.instantiateViewController(withIdentifier: ChoiceCollectionViewController.reuseIdentifier) as? ChoiceCollectionViewController else {
            return
        }
        
        guard let userNickname = userNicknameTextField.text else { return }
        UserDefaultsHelper.standard.userNickname = userNickname
        UserDefaultsHelper.standard.first = true
        UserDefaultsHelper.standard.select = true
        
        let navigationController = UINavigationController(rootViewController: choiceCollectionViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(choiceCollectionViewController, animated: true)
        
    }
    
    @IBAction func userNicknameDone(_ sender: UITextField) {
        view.endEditing(true)
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


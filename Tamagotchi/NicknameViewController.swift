//
//  NicknameViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

class NicknameViewController: UIViewController {

    static let identifier = "NicknameViewController"
    
    @IBOutlet weak var userNicknameTextField: UITextField!
    @IBOutlet weak var mainUIView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet var labelOutletCollection: [UILabel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        designLabel()
        designDoneButton()
        designMainUIView()
        UserDefaults.standard.set(true, forKey: "First")
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
        guard let choiceCollectionViewController = choiceStoryBoard.instantiateViewController(withIdentifier: ChoiceCollectionViewController.identifier) as? ChoiceCollectionViewController else {
            return
        }
        
        
        let tamagotchiStoryBoad = UIStoryboard(name: "Tamagotchi", bundle: nil)
        guard let tamagotchiViewController = tamagotchiStoryBoad.instantiateViewController(withIdentifier: TamagotchiViewController.identifier) as? TamagotchiViewController else {
            return
        }
        
        let userNickname = userNicknameTextField.text!
        print(tamagotchiViewController.userNickname)
        UserDefaults.standard.set(userNickname, forKey: "userNickname")
        UserDefaults.standard.set(false, forKey: "First")
        
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


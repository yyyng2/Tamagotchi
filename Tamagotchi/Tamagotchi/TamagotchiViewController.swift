//
//  TamagotchiViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

var rice = 0
var water = 0
var level = ((UserDefaultsHelper.standard.rice / 5) + (UserDefaultsHelper.standard.water / 2)) / 10

class TamagotchiViewController: UIViewController {

    @IBOutlet weak var waterButton: UIButton!
    @IBOutlet weak var riceButton: UIButton!
    @IBOutlet var whiteLineCollection: [UIImageView]!
    @IBOutlet weak var waterTextField: UITextField!
    @IBOutlet weak var riceTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var scriptLabel: UILabel!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topUIView: UIView!
    @IBOutlet weak var middleUIView: UIView!
    @IBOutlet weak var bottomUIView: UIView!
    @IBOutlet weak var tamagotchiNameLabel: UILabel!
    var userNickname = ""
    var script = ScriptType()
    var tamagotchiData: TamagotchiList?
    var tamagotchiInfo = TamagotchiInfo()
    var indexNumber = UserDefaults.standard.integer(forKey: "index")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        
        setKeyboardObserver()
        designTextField(textfieldName: waterTextField, placeholder: "1~49")
        designTextField(textfieldName: riceTextField, placeholder: "1~99")
        designUIView()
        designNavigationItem()
        designImageView()
        designLabel()
        designUIImageView()
        designButton(buttonName: waterButton, imageName: "drop.circle", titleName: " 물먹기")
        designButton(buttonName: riceButton, imageName: "leaf.circle", titleName: " 밥먹기")
        loadStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        designNavigationItem()
        designImageView()
    }
    
    func designButton(buttonName: UIButton, imageName: String, titleName: String){
        buttonName.setImage(UIImage(systemName: imageName), for: .normal)
        buttonName.setTitle(titleName, for: .normal)
        buttonName.tintColor = .white
        buttonName.layer.borderWidth = 1
        buttonName.layer.borderColor = UIColor.white.cgColor
        buttonName.layer.cornerRadius = 8
    }
    
    func designUIImageView(){
        for view in whiteLineCollection{
            view.image = UIImage(named: "horizontalWhiteLine.png")
            view.contentMode = .scaleToFill
        }
        
    }
    
    func addDoneButtonOnNumpad(textField: UITextField) {
            
            let keypadToolbar: UIToolbar = UIToolbar()
            
            // add a done button to the numberpad
            keypadToolbar.items=[
                UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
                UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
            ]
            keypadToolbar.sizeToFit()
            // add a toolbar with a done button above the number pad
            textField.inputAccessoryView = keypadToolbar
    }//addDoneToKeyPad
    
    func designTextField(textfieldName: UITextField, placeholder: String){
        textfieldName.keyboardType = .numberPad
        textfieldName.placeholder = placeholder
        addDoneButtonOnNumpad(textField: textfieldName)
    }

    
    func designLabel(){
        tamagotchiNameLabel.textAlignment = .center
        tamagotchiNameLabel.textColor = .white
        tamagotchiNameLabel.layer.borderWidth = 1
        tamagotchiNameLabel.layer.borderColor = UIColor.white.cgColor
        tamagotchiNameLabel.backgroundColor = .clear
        tamagotchiNameLabel.clipsToBounds = true
        tamagotchiNameLabel.layer.cornerRadius = 8
        tamagotchiNameLabel.text = " \(tamagotchiInfo.tamoagotchi[indexNumber].tamagotchiName)  "
        scriptLabel.backgroundColor = .clear
        scriptLabel.textColor = .white
        scriptLabel.numberOfLines = 5
        scriptLabel.textAlignment = .center
        statusLabel.textAlignment = .center
        statusLabel.font = .systemFont(ofSize: 14)
        statusLabel.textColor = .white

        loadScript()
    }
    
    func loadStatus(){
        level = ((UserDefaultsHelper.standard.rice / 5) + (UserDefaultsHelper.standard.water / 2)) / 10
        if level > 10 {
            level = 10
        }
        statusLabel.text = "LV \(level) • 밥알 \(UserDefaultsHelper.standard.rice)알 • 물방울 \(UserDefaultsHelper.standard.water)방울"
    }

    func loadScript(){
        if indexNumber == 0{
            scriptLabel.text = "야, \(script.scripts[0].scriptType.randomElement()!)"
        } else if indexNumber == 1 {
            scriptLabel.text = "\(UserDefaultsHelper.standard.userNickname)님 \(script.scripts[1].scriptType.randomElement()!)"
        } else {
            scriptLabel.text = "...\(script.scripts[2].scriptType.randomElement()!)"
        }
    }
    
    func designImageView(){
        topImageView.image = UIImage(named: "bubble.png")
        topImageView.backgroundColor = .clear
        tamagotchiImageView.backgroundColor = .clear
        designLevelImageView()
    }
    
    func changeLevelImage(imageName: String){
        tamagotchiImageView.image = UIImage(named: imageName)
    }
    
    func designLevelImageView(){
        if level < 2{
                changeLevelImage(imageName: "\(indexNumber + 1)-1.png")
            } else if level > 8{
                changeLevelImage(imageName: "\(indexNumber + 1)-9.png")
                } else {
                    changeLevelImage(imageName: "\(indexNumber + 1)-\(level).png")
                }       
    }
    
    func designUIView(){
        topUIView.backgroundColor = .clear
        middleUIView.backgroundColor = .clear
        bottomUIView.backgroundColor = .clear
    }

    
    func designNavigationItem(){
        
        title = "\(UserDefaultsHelper.standard.userNickname)님의 다마고치"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
    }
    
    @objc func rightBarButtonItemTapped(){
        let settingStoryBoard = UIStoryboard(name: "Setting", bundle: nil)
        guard let settingTableViewController = settingStoryBoard.instantiateViewController(withIdentifier: SettingTableViewController.reuseIdentifier) as? SettingTableViewController else {
            return
        }
        settingTableViewController.modalPresentationStyle = .fullScreen
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(settingTableViewController, animated: true)
    }
    

    @IBAction func riceButtonTapped(_ sender: UIButton) {
        let currentValue = UserDefaultsHelper.standard.rice
        var updateValue = 0
        guard let text = riceTextField.text else {return}
        if text == ""{
            updateValue = currentValue + 1
            UserDefaultsHelper.standard.rice = updateValue
        } else if text != "" {
            let codeNum = Int(riceTextField.text!)
            if codeNum == nil {
                alert(title: "!", message: "너무 길거나 숫자가 아닙니다.")
            } else if riceTextField.text != ""{
                guard let codeNum = Int(riceTextField.text!) else {return}
                if codeNum > 99{
                    alert(title: "!", message: "99이하로 입력해주세요.")
                } else {
                guard let addedValue = Int(riceTextField.text!) else { return }
              
                updateValue = currentValue + addedValue
                UserDefaultsHelper.standard.rice = updateValue
                print(updateValue)
                }
            }
        }
        
        rice += UserDefaultsHelper.standard.rice
        loadStatus()
        loadScript()
        designLevelImageView()
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        let currentValue = UserDefaultsHelper.standard.water
        var updateValue = 0
        guard let text = waterTextField.text else {return}
        if text == ""{
            updateValue = currentValue + 1
            UserDefaultsHelper.standard.water = updateValue
        } else if text != "" {
            let codeNum = Int(waterTextField.text!)
            if codeNum == nil {
                alert(title: "!", message: "너무 길거나 숫자가 아닙니다.")
            } else if waterTextField.text != ""{
                guard let codeNum = Int(waterTextField.text!) else {return}
                if codeNum > 49{
                    alert(title: "!", message: "49이하로 입력해주세요.")
                } else {
                guard let addedValue = Int(waterTextField.text!) else { return }
              
                updateValue = currentValue + addedValue
                UserDefaultsHelper.standard.water = updateValue
                print(updateValue)
                }
            }
        }
 
        
        water += UserDefaultsHelper.standard.water
        designLevelImageView()
        loadStatus()
        loadScript()
    
    }
    
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        UserDefaults.standard.set(false, forKey: "keyboard")
        view.endEditing(true)
    }
    
}

//
//  TamagotchiViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

var rice = 0
var water = 0
var level = (UserDefaults.standard.integer(forKey: "rice")/5) + (UserDefaults.standard.integer(forKey: "water")/2)

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
    
    static let identifier = "TamagotchiViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        
        setKeyboardObserver()
        designTextField()
        designUIView()
        designNavigationItem()
        designImageView()
        designLabel()
        designUIImageView()
        designButton()
        loadStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        designNavigationItem()
    }
    
    func designButton(){
        waterButton.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        waterButton.setTitle(" 물먹기", for: .normal)
        waterButton.tintColor = .white
        riceButton.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        riceButton.setTitle(" 밥먹기", for: .normal)
        riceButton.tintColor = .white
        waterButton.layer.borderWidth = 1
        waterButton.layer.borderColor = UIColor.white.cgColor
        waterButton.layer.cornerRadius = 8
        riceButton.layer.borderColor = UIColor.white.cgColor
        riceButton.layer.borderWidth = 1
        riceButton.layer.cornerRadius = 8
        
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
    
    func designTextField(){
        waterTextField.keyboardType = .numberPad
        waterTextField.placeholder = "1~50"
        riceTextField.keyboardType = .numberPad
        riceTextField.placeholder = "1~99"
        addDoneButtonOnNumpad(textField: waterTextField)
        addDoneButtonOnNumpad(textField: riceTextField)
    }

    
    func designLabel(){
        tamagotchiNameLabel.textAlignment = .center
        tamagotchiNameLabel.textColor = .white
        tamagotchiNameLabel.layer.borderWidth = 1
        tamagotchiNameLabel.layer.borderColor = UIColor.white.cgColor
        tamagotchiNameLabel.backgroundColor = .clear
        tamagotchiNameLabel.clipsToBounds = true
        tamagotchiNameLabel.layer.cornerRadius = 8
        tamagotchiNameLabel.text = " \(tamagotchiInfo.tamoagotchi[indexNumber].tamagotchiName) "
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
        level = (UserDefaults.standard.integer(forKey: "rice")/5) + (UserDefaults.standard.integer(forKey: "water")/2)
        if level > 10 {
            level = 10
        }
        UserDefaults.standard.set(level, forKey: "level")
        statusLabel.text = "LV \(UserDefaults.standard.integer(forKey: "level")) • 밥알 \(UserDefaults.standard.integer(forKey: "rice"))알 • 물방울 \(UserDefaults.standard.integer(forKey: "water"))방울"
    }

    func loadScript(){
        if indexNumber == 0{
            scriptLabel.text = "야, \(script.scripts[0].scriptType.randomElement()!)"
        } else if indexNumber == 1 {
            guard let nickName = UserDefaults.standard.string(forKey: "userNickname") else {
                return
            }
            scriptLabel.text = "\(nickName)님 \(script.scripts[1].scriptType.randomElement()!)"
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
    
    func designLevelImageView(){
        if indexNumber == 0{
            if level < 2{
                tamagotchiImageView.image = UIImage(named: "1-1.png")
            } else if level == 2{
                tamagotchiImageView.image = UIImage(named: "1-2.png")
                } else if level == 3{
                    tamagotchiImageView.image = UIImage(named: "1-3.png")
                } else if level == 4{
                    tamagotchiImageView.image = UIImage(named: "1-4.png")
                } else if level == 5{
                    tamagotchiImageView.image = UIImage(named: "1-5.png")
                } else if level == 6{
                    tamagotchiImageView.image = UIImage(named: "1-6.png")
                } else if level == 7{
                    tamagotchiImageView.image = UIImage(named: "1-7.png")
                } else if level == 8{
                    tamagotchiImageView.image = UIImage(named: "1-8.png")
                } else if level > 8{
                    tamagotchiImageView.image = UIImage(named: "1-9.png")
                }
            } else if indexNumber == 1{
                if level < 2{
                    tamagotchiImageView.image = UIImage(named: "2-1.png")
                } else if level == 2{
                    tamagotchiImageView.image = UIImage(named: "2-2.png")
                    } else if level == 3{
                    tamagotchiImageView.image = UIImage(named: "2-3.png")
                    } else if level == 4{
                        tamagotchiImageView.image = UIImage(named: "2-4.png")
                    } else if level == 5{
                        tamagotchiImageView.image = UIImage(named: "2-5.png")
                    } else if level == 6{
                        tamagotchiImageView.image = UIImage(named: "2-6.png")
                    } else if level == 7{
                        tamagotchiImageView.image = UIImage(named: "2-7.png")
                    } else if level == 8{
                        tamagotchiImageView.image = UIImage(named: "2-8.png")
                    } else if level > 8{
                        tamagotchiImageView.image = UIImage(named: "2-9.png")
                    }
            } else if indexNumber == 2{
                        if level < 2{
                            tamagotchiImageView.image = UIImage(named: "3-1.png")
                        } else if level == 2{
                            tamagotchiImageView.image = UIImage(named: "3-2.png")
                            } else if level == 3{
                                tamagotchiImageView.image = UIImage(named: "3-3.png")
                            } else if level == 4{
                                tamagotchiImageView.image = UIImage(named: "3-4.png")
                            } else if level == 5{
                                tamagotchiImageView.image = UIImage(named: "3-5.png")
                            } else if level == 6{
                                tamagotchiImageView.image = UIImage(named: "3-6.png")
                            } else if level == 7{
                                tamagotchiImageView.image = UIImage(named: "3-7.png")
                            } else if level == 8{
                                tamagotchiImageView.image = UIImage(named: "3-8.png")
                            } else if level > 8{
                                tamagotchiImageView.image = UIImage(named: "3-9.png")
                            }
            }
    }
    
    func designUIView(){
        topUIView.backgroundColor = .clear
        middleUIView.backgroundColor = .clear
        bottomUIView.backgroundColor = .clear
    }

    
    func designNavigationItem(){
        guard let nickName = UserDefaults.standard.string(forKey: "userNickname") else {
            return
        }
        title = "\(nickName)님의 다마고치"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
    }
    
    @objc func rightBarButtonItemTapped(){
        let settingStoryBoard = UIStoryboard(name: "Setting", bundle: nil)
        guard let settingTableViewController = settingStoryBoard.instantiateViewController(withIdentifier: SettingTableViewController.identifier) as? SettingTableViewController else {
            return
        }
        settingTableViewController.modalPresentationStyle = .fullScreen
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.pushViewController(settingTableViewController, animated: true)
    }
    

    @IBAction func riceButtonTapped(_ sender: UIButton) {
        let currentValue:Int = UserDefaults.standard.integer(forKey: "rice")
        var updateValue = 0

        if riceTextField.text == ""{
            updateValue = currentValue + 1
            UserDefaults.standard.set(updateValue, forKey: "rice")
        } else if riceTextField.text != "" {
            let codeNum = Int(riceTextField.text!)
            if codeNum == nil {
                alert(title: "!", message: "숫자로만 입력해주세요.")
            } else if riceTextField.text != ""{
                if Int(riceTextField.text!)! > 100{
                    return
                }
            } else {
                updateValue = currentValue + Int(riceTextField.text!)!
                UserDefaults.standard.set(updateValue, forKey: "rice")
            }
           
        }
        
        rice += UserDefaults.standard.integer(forKey: "rice")
        loadStatus()
        loadScript()
        designLevelImageView()
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        let currentValue:Int = UserDefaults.standard.integer(forKey: "water")
        var updateValue = 0
        if waterTextField.text == ""{
            updateValue = currentValue + 1
            UserDefaults.standard.set(updateValue, forKey: "water")
        } else if waterTextField.text != "" {
            let codeNum = Int(waterTextField.text!)
            if codeNum == nil {
                alert(title: "!", message: "숫자로만 입력해주세요.")
            } else if waterTextField.text != ""{
                if Int(waterTextField.text!)! > 50{
                    return
                }
            } else {
                updateValue = currentValue + Int(waterTextField.text!)!
                UserDefaults.standard.set(updateValue, forKey: "water")
            }
           
        }
        
        rice += UserDefaults.standard.integer(forKey: "water")
        designLevelImageView()
        loadStatus()
        loadScript()
    }
    
    @IBAction func gestureTapped(_ sender: UITapGestureRecognizer) {
        UserDefaults.standard.set(false, forKey: "keyboard")
        view.endEditing(true)
    }
    
}

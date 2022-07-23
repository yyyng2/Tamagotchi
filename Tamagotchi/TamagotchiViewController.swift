//
//  TamagotchiViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

class TamagotchiViewController: UIViewController {

    var userNickname = ""
    
    static let identifier = "TamagotchiViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designNavigationItem()
    }
    
    func designNavigationItem(){
        guard let nickName = UserDefaults.standard.string(forKey: "userNickname") else {
            return
        }
        title = "\(nickName)님의 다마고치"
        navigationItem.hidesBackButton = true
        
    }
    

  

}

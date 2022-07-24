//
//  SettingTableViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/23.
//

import UIKit



class SettingTableViewController: UITableViewController {

    let settingOption = ["내 이름 설정하기", "다마고치 설정하기", "데이터 초기화"]
    let settingImage = ["pencil","moon.fill", "arrow.clockwise"]
    var settingDetail = [UserDefaults.standard.string(forKey: "userNickname"), "", ""]
    
    static let identifier = "SettingTableViewController"
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        designNavigationItem()
       
    }
    
    func refresh(){
        settingDetail = [UserDefaults.standard.string(forKey: "userNickname"), "", ""]
        tableView.reloadData()
    }

    func designNavigationItem(){
        title = "설정"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = settingOption[indexPath.row]
        cell.imageView?.image = UIImage(systemName: settingImage[indexPath.row])
        cell.detailTextLabel?.text = settingDetail[indexPath.row]
        cell.tintColor = .white
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.backgroundColor = .clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingStoryBoard = UIStoryboard(name: "Setting", bundle: nil)
        let choiceStoryBoard = UIStoryboard(name: "Choice", bundle: nil)
        if indexPath == [0,0] {
            guard let nicknameViewController = settingStoryBoard.instantiateViewController(withIdentifier: NicknameSettingViewController.identifier) as? NicknameSettingViewController else {
                return
            }
            let navigationController = UINavigationController(rootViewController: nicknameViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(nicknameViewController, animated: true)
        } else if indexPath == [0,1] {
            func ChangeAlert(title: String, message: String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: {action in
                    guard let choiceViewController = choiceStoryBoard.instantiateViewController(withIdentifier: ChoiceCollectionViewController.identifier) as? ChoiceCollectionViewController else {
                        return
                    }
                    let navigationController = UINavigationController(rootViewController: choiceViewController)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(choiceViewController, animated: true)
                }))
                present(alert, animated: true)
            }
            ChangeAlert(title: "레벨이 유지됩니다!", message: "성격때문에 서로 말투도 달라요!")
            guard let choiceViewController = choiceStoryBoard.instantiateViewController(withIdentifier: ChoiceCollectionViewController.identifier) as? ChoiceCollectionViewController else {
                return
            }
            let navigationController = UINavigationController(rootViewController: choiceViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(choiceViewController, animated: true)
        } else if indexPath == [0,2] {
            let warning = UIAlertController(title: "경고", message: "닉네임과 레벨이 모두 초기화됩니다", preferredStyle: .alert)
            warning.addAction(UIAlertAction(title: "초기화", style: .destructive, handler: {action in
                //working on ios 13+ with sceneDelegate.
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                //앱을 초기화
                
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyBoard.instantiateViewController(withIdentifier: NicknameViewController.identifier) as! NicknameViewController
                sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: viewController)
                sceneDelegate?.window?.makeKeyAndVisible()
                //userdefault 초기화
                UserDefaults.standard.removeObject(forKey: "water")
                UserDefaults.standard.removeObject(forKey: "rice")
                UserDefaults.standard.removeObject(forKey: "userNickname")
                UserDefaults.standard.removeObject(forKey: "level")
                UserDefaults.standard.removeObject(forKey: "index")
            }))
            warning.addAction(UIAlertAction(title: "취소", style: .cancel))
            present(warning, animated: true)
        }
    }
    
}

//
//  UIViewController + Extension.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/23.
//

import Foundation
import UIKit

extension UIViewController {
    //구글링으로 찾음. 키보드 크기만큼 화면이동하는 코드
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //퍼온 코드 문제 발생. 키보드 계속 호출되면 화면이 저 멀리까지 올라가버림. userdefaults값을 주고 방지.
        if UserDefaults.standard.bool(forKey: "keyboard") == false{
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 1) {
                    self.view.window?.frame.origin.y -= keyboardHeight
                    UserDefaults.standard.set(true, forKey: "keyboard")
                }
            }
        }
        return
         
      }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 1) {
                    self.view.window?.frame.origin.y += keyboardHeight
                    UserDefaults.standard.set(false, forKey: "keyboard")
                }
            }
        }
    }
}


extension UIViewController {
    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .cancel))
        present(alert, animated: true)
    }

}


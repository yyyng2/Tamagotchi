//
//  UIViewController + Extension.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                  let keyboardRectangle = keyboardFrame.cgRectValue
                  let keyboardHeight = keyboardRectangle.height
              UIView.animate(withDuration: 1) {
                  self.view.window?.frame.origin.y -= keyboardHeight
              }
          }
      }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 1) {
                    self.view.window?.frame.origin.y += keyboardHeight
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


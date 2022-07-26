//
//  TamagotchiDetailViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

class TamagotchiDetailViewController: UIViewController {

    var tamagotchiData: TamagotchiList?
    var tamagoNumber = TamagotchiInfo()
    var indexNumber = 0
    
    @IBOutlet weak var buttonUIView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tamagotchiNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var whiteLineCollection: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemGray.withAlphaComponent(0.5)
        designMainUIView()
        designLabel()
        designUIImageView()
        designButton()
        designTamagotchiImage()
    }
    
    func designTamagotchiImage(){
        tamagotchiImageView.image = tamagoNumber.tamoagotchi[indexNumber].tamagotchiBlurImage
        tamagotchiImageView.backgroundColor = .clear
    }
    
    func designMainUIView(){
        backgroundView.backgroundColor = .systemGray
        backgroundView.layer.cornerRadius = 8
        buttonUIView.backgroundColor = .clear
    }
    
    func designLabel(){
        descriptionLabel.textColor = .white
        tamagotchiNameLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        tamagotchiNameLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 5
        tamagotchiNameLabel.text = tamagoNumber.tamoagotchi[indexNumber].tamagotchiName
        descriptionLabel.text = tamagoNumber.tamoagotchi[indexNumber].tamagotchiDescription
        descriptionLabel.font = .systemFont(ofSize: 14)

    }
    
    func designUIImageView(){
        for view in whiteLineCollection{
            view.image = UIImage(named: "horizontalWhiteLine.png")
            view.contentMode = .scaleToFill
        }
        
    }
    
    func designButton(){
        let select = UserDefaultsHelper.standard.select
        if select == true{
            doneButton.setTitle("시작하기", for: .normal)
        } else {
            doneButton.setTitle("변경하기", for: .normal)
        }
        
        cancelButton.setTitle("취소", for: .normal)
        doneButton.tintColor = .white
        cancelButton.tintColor = .white
        doneButton.backgroundColor = .clear
        cancelButton.backgroundColor = .systemGray2
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.maskedCorners = CACornerMask.layerMinXMaxYCorner
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let tamagotchiStoryBoard = UIStoryboard(name: "Tamagotchi", bundle: nil)
        guard let tamagotchiViewController = tamagotchiStoryBoard.instantiateViewController(withIdentifier: TamagotchiViewController.reuseIdentifier) as? TamagotchiViewController else {
            return
        }

        UserDefaultsHelper.standard.index = indexNumber
        
        tamagotchiViewController.indexNumber = indexNumber

        tamagotchiViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tamagotchiViewController, animated: false)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}




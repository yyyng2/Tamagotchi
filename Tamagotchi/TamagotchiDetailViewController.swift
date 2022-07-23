//
//  TamagotchiDetailViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

class TamagotchiDetailViewController: UIViewController {

    var tamagotchiData: TamagotchiList?
    
    static let identifier = "TamagotchiDetailViewController"
    
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
        tamagotchiImageView.image = tamagotchiData?.tamagotchiBlurImage
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
        tamagotchiNameLabel.text = tamagotchiData?.tamagotchiName
        descriptionLabel.text = tamagotchiData?.tamagotchiDescription
        descriptionLabel.font = .systemFont(ofSize: 14)

    }
    
    func designUIImageView(){
        for view in whiteLineCollection{
            view.image = UIImage(named: "horizontalWhiteLine.png")
            view.contentMode = .scaleToFill
        }
        
    }
    
    func designButton(){
        doneButton.setTitle("시작하기", for: .normal)
        cancelButton.setTitle("취소", for: .normal)
        doneButton.tintColor = .white
        cancelButton.tintColor = .white
        doneButton.backgroundColor = .clear
        cancelButton.backgroundColor = .systemGray2
    }

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let tamagotchiStoryBoard = UIStoryboard(name: "Tamagotchi", bundle: nil)
        guard let tamagotchiViewController = tamagotchiStoryBoard.instantiateViewController(withIdentifier: TamagotchiViewController.identifier) as? TamagotchiViewController else {
            return
        }
        
        tamagotchiViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tamagotchiViewController, animated: true)
        
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}




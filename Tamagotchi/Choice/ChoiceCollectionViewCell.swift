//
//  ChoiceCollectionViewCell.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

class ChoiceCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var cellImageUIView: UIView!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var tamagotchiNameLabel: UILabel!
    static let identifier = "ChoiceCollectionViewCell"
    
    func configureCell(tamagotchi: TamagotchiList){
        cellBackgroundView.backgroundColor = .clear
        cellImageUIView.backgroundColor = .clear
        tamagotchiNameLabel.text = tamagotchi.tamagotchiName
        tamagotchiImageView.image = tamagotchi.tamagotchiBlurImage
        tamagotchiNameLabel.font = .systemFont(ofSize: 13)
        tamagotchiNameLabel.textColor = .white
        tamagotchiNameLabel.textAlignment = .center
        tamagotchiNameLabel.layer.borderWidth = 1
        tamagotchiNameLabel.layer.borderColor = UIColor.white.cgColor
        tamagotchiNameLabel.layer.cornerRadius = 8
        backgroundColor = .clear
    }
}

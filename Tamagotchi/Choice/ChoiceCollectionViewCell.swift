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
    
}

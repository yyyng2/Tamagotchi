//
//  ChoiceCollectionViewController.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChoiceCollectionViewController: UICollectionViewController {

    var tamagotchiList = TamagotchiInfo()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout.collectionView?.backgroundColor = .systemGray2
        designCell()
        designNavigationItem()
    }
    
    func designNavigationItem(){
        let select = UserDefaults.standard.bool(forKey: "select")
        if select {
            navigationItem.title = "다마고치 선택하기"
        } else {
            navigationItem.title = "다마고치 변경하기"
        }
        
        navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    func designCell(){
        let cellLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 4)
        cellLayout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2 )
        cellLayout.scrollDirection = .vertical
        cellLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        cellLayout.minimumLineSpacing = spacing
        cellLayout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = cellLayout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChoiceCollectionViewCell.reuseIdentifier, for: indexPath) as? ChoiceCollectionViewCell else {
            return UICollectionViewCell()
        }
        let tamagotchi = tamagotchiList.tamoagotchi[indexPath.row]
        cell.configureCell(tamagotchi: tamagotchi)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < 3{
            let indexNumber = indexPath.item
            let tamagotchiDetailStoryBoard = UIStoryboard(name: "Choice", bundle: nil)
            guard let tamagotchiDetailViewController = tamagotchiDetailStoryBoard.instantiateViewController(withIdentifier: TamagotchiDetailViewController.reuseIdentifier) as? TamagotchiDetailViewController else {
            return
            }
            let navigationViewcontroller = UINavigationController(rootViewController: tamagotchiDetailViewController)
            navigationViewcontroller.modalPresentationStyle = .overCurrentContext
            tamagotchiDetailViewController.tamagotchiData = tamagotchiList.tamoagotchi[indexNumber]
            tamagotchiDetailViewController.indexNumber = indexNumber
            
            UserDefaultsHelper.standard.detail = true
            
            self.present(navigationViewcontroller, animated: true)
        } else {
            let alert = UIAlertController(title: "!", message: "준비중입니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            present(alert, animated: true)
           
        }
    }
    
}

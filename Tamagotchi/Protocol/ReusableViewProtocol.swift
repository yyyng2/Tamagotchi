//
//  ReusableViewProtocol.swift
//  Tamagotchi
//
//  Created by Y on 2022/08/01.
//

import UIKit

protocol ReusableViewProtocol{
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol{
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView: ReusableViewProtocol{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

extension UITableView: ReusableViewProtocol{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol{
    static var reuseIdentifier: String{
        return String(describing: self)
    }
}

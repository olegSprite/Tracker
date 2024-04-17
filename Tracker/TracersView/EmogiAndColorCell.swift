//
//  EmogiAndColorCell.swift
//  Tracker
//
//  Created by Олег Спиридонов on 17.04.2024.
//

import Foundation
import UIKit

final class EmogiAndColorCell: UICollectionViewCell {
    
    let object = UIView()
    
    func setupCell() {
        object.backgroundColor = .red
        object.translatesAutoresizingMaskIntoConstraints = false
        addSubview(object)
        NSLayoutConstraint.activate([
            object.heightAnchor.constraint(equalToConstant: 50),
            object.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

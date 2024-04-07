//
//  TracerViewCell.swift
//  Tracker
//
//  Created by Олег Спиридонов on 07.04.2024.
//

import Foundation
import UIKit

final class TracerViewCell: UICollectionViewCell {
    
    let nameLable = UILabel()
    private let emogiImage = UIImageView()
    private let daysCountLable = UILabel()
    private let completeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLable)
        nameLable.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        nameLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}


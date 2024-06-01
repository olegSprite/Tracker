//
//  StatisticViewCell.swift
//  Tracker
//
//  Created by Олег Спиридонов on 30.05.2024.
//

import Foundation
import UIKit

final class StatisticViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let numberLable = UILabel()
    private let textLable = UILabel()
    private let gradientLayer = CAGradientLayer()
    private let shapeLayer = CAShapeLayer()
    
    // MARK: - Private Methods
    
    private func setupGradientBorder() {
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds
        shapeLayer.lineWidth = 1
        shapeLayer.path = UIBezierPath(roundedRect: bounds.insetBy(dx: 2, dy: 2), cornerRadius: 16).cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        gradientLayer.mask = shapeLayer
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        shapeLayer.path = UIBezierPath(roundedRect: bounds.insetBy(dx: 2, dy: 2), cornerRadius: 16).cgPath
    }
    
    private func addNubberLable() {
        numberLable.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        addSubview(numberLable)
        numberLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            numberLable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12)
        ])
    }
    
    private func addTextLable() {
        textLable.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        addSubview(textLable)
        textLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            textLable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }
    
    // MARK: - Public Methods
    
    func setupView(count: Int, text: String) {
        setupGradientBorder()
        addNubberLable()
        addTextLable()
        numberLable.text = String(count)
        textLable.text = text
    }
}

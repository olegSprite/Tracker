//
//  EmogiAndColorCell.swift
//  Tracker
//
//  Created by Олег Спиридонов on 17.04.2024.
//

import Foundation
import UIKit

final class EmogiAndColorCell: UICollectionViewCell {
    
    let view = UIView()
    lazy var emogi: UILabel = {
        let lable = UILabel()
        return lable
    }()
    lazy var colorView: UIView = {
        let colorView = UIView()
        return colorView
    }()
    
    func setupCell() {
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 48),
            view.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func setupEmogi(_ emogi: String) {
        self.emogi.text = emogi
        self.emogi.font = UIFont.systemFont(ofSize: 32)
        self.emogi.textAlignment = .center
        self.emogi.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self.emogi)
        NSLayoutConstraint.activate([
            self.emogi.heightAnchor.constraint(equalToConstant: 48),
            self.emogi.widthAnchor.constraint(equalToConstant: 48),
            self.emogi.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.emogi.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupColor(color: UIColor) {
        colorView.backgroundColor = color
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = 8
        view.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorView.heightAnchor.constraint(equalToConstant: 40),
            colorView.widthAnchor.constraint(equalToConstant: 40),
            colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func selectEmogiCell() {
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 235/255, alpha: 1)
    }
    
    func deselectEmogiCell() {
        view.layer.cornerRadius = 0
        view.backgroundColor = nil
    }
    
    func selectColorCell() {
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 3
        let color = colorView.backgroundColor?.withAlphaComponent(0.3)
        view.layer.borderColor = color?.cgColor
    }
    
    func deselectColorCell() {
        view.layer.cornerRadius = 0
        view.layer.borderWidth = 0
        view.layer.borderColor = nil
    }
}

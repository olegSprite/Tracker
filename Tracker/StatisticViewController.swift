//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import Foundation
import UIKit

final class StatisticViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let plugImage = UIImageView()
    private let plugLable = UILabel()
    
    // MARK: - Public Properties
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        addPlug()
    }
    
    // MARK: - Private Methods
    
    private func addPlug() {
        plugImage.image = UIImage(named: "cryEmoji")
        plugImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugImage)
        NSLayoutConstraint.activate([
            plugImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plugImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plugImage.widthAnchor.constraint(equalToConstant: 80),
            plugImage.heightAnchor.constraint(equalToConstant: 80)
        ])
        plugLable.text = "Анализировать пока нечего"
        plugLable.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        plugLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugLable)
        NSLayoutConstraint.activate([
            plugLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plugLable.topAnchor.constraint(equalTo: plugImage.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupNavBar() {
        title = "Статистика"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Public Methods
    // MARK: - Private Actions
    // MARK: - Public Actions
}

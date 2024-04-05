//
//  ViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import UIKit

final class TracersViewController: UIViewController {
    
    private let plugImageView = UIImageView()
    private let plugLable = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupNavBar()
        addPlugImage()
        addPlugLable()
    }
    
    private func setupNavBar() {
        title = "Трекеры"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: nil, action: nil)
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    private func addPlugImage() {
        plugImageView.image = UIImage(named: "plugImage")
        plugImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugImageView)
        NSLayoutConstraint.activate([
            plugImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plugImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plugImageView.widthAnchor.constraint(equalToConstant: 80),
            plugImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func addPlugLable() {
        plugLable.text = "Что будем отслеживать?"
        plugLable.font = UIFont.systemFont(ofSize: 12)
        plugLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugLable)
        NSLayoutConstraint.activate([
            plugLable.topAnchor.constraint(equalTo: plugImageView.bottomAnchor, constant: 8),
            plugLable.centerXAnchor.constraint(equalTo: plugImageView.centerXAnchor)
        ])
    }
}


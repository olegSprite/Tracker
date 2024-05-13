//
//  FirstOnboardingScreenViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 12.05.2024.
//

import Foundation
import UIKit

final class OnboardingScreenViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let lableView = UILabel()
    private var numberOfScreen: Int?
    
    init(image: UIImage, numberOfScreen: Int) {
        super.init(nibName: nil, bundle: nil)
        self.imageView.image = image
        self.numberOfScreen = numberOfScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
        addLable()
    }
    
    private func addImage() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addLable() {
        switch numberOfScreen {
        case 1: lableView.text = "Отслеживайте только то, что хотите"
        case 2: lableView.text = "Даже если это не литры воды и йога"
        default: lableView.text = ""
        }
        lableView.textColor = .black
        lableView.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        lableView.textAlignment = .center
        lableView.numberOfLines = 2
        lableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lableView)
        NSLayoutConstraint.activate([
            lableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

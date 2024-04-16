//
//  HabitOrEventViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 09.04.2024.
//

import Foundation
import UIKit

final class HabitOrEventViewController: UIViewController {
    
    private let habitButton = UIButton()
    private let trackerButton = UIButton()
    var originalViewController: TrackersViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupViews()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = .white
        addHabitButton()
        addTracerButton()
    }
    
    private func setupNavBar() {
        title = "Создание трекера"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func createButton(button: UIButton, title: String, selector: Selector) {
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.backgroundColor = .black
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(button)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
    }
    
    private func addHabitButton() {
        createButton(button: self.habitButton, title: "Нерегулярное событие", selector: #selector(tapHubitButton))
        habitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            habitButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 8),
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            habitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            habitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func addTracerButton() {
        createButton(button: self.trackerButton, title: "Привычка", selector: #selector(tapTracerButton))
        trackerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackerButton.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -8),
            trackerButton.heightAnchor.constraint(equalToConstant: 60),
            trackerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            trackerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func goToNextVC(isTracer: Bool) {
        let vc = CreateTrackerViewController()
        vc.isTracer = isTracer 
        vc.habitOrEventViewController = self
        vc.delegate = originalViewController
        let navBar = UINavigationController(rootViewController: vc)
        navBar.modalPresentationStyle = .popover
        self.present(navBar, animated: true)
    }
    
    // MARK: - Private Actions
    
    @objc private func tapHubitButton() {
        goToNextVC(isTracer: false)
    }
    
    @objc private func tapTracerButton() {
        goToNextVC(isTracer: true)
    }
}

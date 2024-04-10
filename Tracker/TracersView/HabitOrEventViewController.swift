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
    private let tracerButton = UIButton()
    private let titileLable = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        title = "Создание трекера"
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        addHabitButton()
        addTracerButton()
    }
    
    private func addTitle() {
        titileLable.text = "Создание трекера"
        // тут заголовок
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
        createButton(button: self.tracerButton, title: "Привычка", selector: #selector(tapTracerButton))
        tracerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tracerButton.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -8),
            tracerButton.heightAnchor.constraint(equalToConstant: 60),
            tracerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tracerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func goToNextVC(isTracer: Bool) {
        let vc = CreateTracerViewController()
        vc.isTracer = isTracer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func tapHubitButton() {
        goToNextVC(isTracer: false)
    }
    
    @objc private func tapTracerButton() {
        goToNextVC(isTracer: true)
    }
}

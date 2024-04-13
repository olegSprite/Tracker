//
//  TimetableViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 10.04.2024.
//

import Foundation
import UIKit

final class TimetableViewController: UIViewController {
    
    private let timetableTableView = UITableView()
    private let completeButton = UIButton()
    
    var daysOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupTableView()
        addButton()
    }
    
    private func setupNavBar() {
        title = "Расписание"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupTableView() {
        timetableTableView.dataSource = self
        timetableTableView.delegate = self
        timetableTableView.layer.masksToBounds = true
        timetableTableView.layer.cornerRadius = 16
        view.addSubview(timetableTableView)
        timetableTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timetableTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            timetableTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timetableTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            timetableTableView.heightAnchor.constraint(equalToConstant: 525)
        ])
    }
    
    private func addButton() {
        completeButton.setTitle("Готово", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.addTarget(self, action: #selector(tapCompleteButton), for: .touchUpInside)
        completeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        completeButton.layer.masksToBounds = true
        completeButton.layer.cornerRadius = 16
        completeButton.backgroundColor = .black
        view.addSubview(completeButton)
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            completeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            completeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    @objc func switchValueChanged(sender: UISwitch) {
            // Обрабатываем изменение состояния переключателя
            print("Переключатель \(sender.isOn ? "включен" : "выключен")")
        }
    
    @objc private func tapCompleteButton() {
        print("кнопка работает")
    }
}

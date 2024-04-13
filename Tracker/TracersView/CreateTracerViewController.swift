//
//  createTracerViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 09.04.2024.
//

import Foundation
import UIKit

final class CreateTracerViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let nameTracerTextField = UITextField()
    private let buttonsOfCattegoryOrTimetableTableView = UITableView()
    private let exitButton = UIButton()
    private let saveButton = UIButton()
    
    var isTracer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        addViews()
    }
    
    private func setupNavBar() {
        title = isTracer ? "Новая привычка" : "Новое нерегулярное событие"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addViews() {
        view.backgroundColor = .white
        addScrollView()
        addNameTracerTextField()
        addButtonsOfCattegoryOrTimetableTableView()
        addExitButton()
        addSaveButton()
    }
    
    private func addScrollView() {
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 300)
        contentView.frame.size = scrollView.contentSize
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func addNameTracerTextField() {
        nameTracerTextField.placeholder = "Введите название трекера"
        nameTracerTextField.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 235/255, alpha: 0.3)
        nameTracerTextField.layer.masksToBounds = true
        nameTracerTextField.layer.cornerRadius = 16
        nameTracerTextField.setLeftPaddingPoints(16)
        contentView.addSubview(nameTracerTextField)
        nameTracerTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTracerTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTracerTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTracerTextField.heightAnchor.constraint(equalToConstant: 75),
            nameTracerTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        ])
    }
    
    private func addButtonsOfCattegoryOrTimetableTableView() {
        buttonsOfCattegoryOrTimetableTableView.dataSource = self
        buttonsOfCattegoryOrTimetableTableView.delegate = self
        buttonsOfCattegoryOrTimetableTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        buttonsOfCattegoryOrTimetableTableView.layer.masksToBounds = true
        buttonsOfCattegoryOrTimetableTableView.layer.cornerRadius = 16
        contentView.addSubview(buttonsOfCattegoryOrTimetableTableView)
        buttonsOfCattegoryOrTimetableTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsOfCattegoryOrTimetableTableView.topAnchor.constraint(equalTo: nameTracerTextField.bottomAnchor, constant: 24),
            buttonsOfCattegoryOrTimetableTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            buttonsOfCattegoryOrTimetableTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            buttonsOfCattegoryOrTimetableTableView.heightAnchor.constraint(equalToConstant: isTracer ? 150 : 75)
        ])
    }
    
    private func addExitButton() {
        exitButton.setTitle("Отменить", for: .normal)
        exitButton.setTitleColor(UIColor(red: 245/255, green: 107/255, blue: 108/255, alpha: 1), for: .normal)
        exitButton.addTarget(self, action: #selector(tapExitButton), for: .touchUpInside)
        exitButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        exitButton.layer.masksToBounds = true
        exitButton.layer.borderWidth = 1
        exitButton.layer.borderColor = CGColor(red: 245/255, green: 107/255, blue: 108/255, alpha: 1)
        exitButton.layer.cornerRadius = 16
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        NSLayoutConstraint.activate([
            exitButton.heightAnchor.constraint(equalToConstant: 60),
            exitButton.widthAnchor.constraint(equalToConstant: 166),
            exitButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -4),
            exitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34)
        ])
    }
    
    private func addSaveButton() {
        saveButton.setTitle("Создать", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = UIColor(red: 174/255, green: 175/255, blue: 180/255, alpha: 1)
        saveButton.addTarget(self, action: #selector(tapSaveButton), for: .touchUpInside)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        saveButton.layer.masksToBounds = true
        saveButton.layer.cornerRadius = 16
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.widthAnchor.constraint(equalToConstant: 166),
            saveButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 4),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34)
        ])
    }
    
    @objc private func tapExitButton() {
        // Нужна реализация нормального навигейшина, чтобы не дрочиться с костылями
        self.dismiss(animated: true)
        self.navigationController?.presentedViewController?.dismiss(animated: true)
    }
    
    @objc private func tapSaveButton() {
        
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

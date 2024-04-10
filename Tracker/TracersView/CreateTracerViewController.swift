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
    
    var isTracer = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = isTracer ? "Новая привычка" : "Новое нерегулярное событие"
        
        addViews()
    }
    
    private func addViews() {
        view.backgroundColor = .white
        addScrollView()
        addNameTracerTextField()
        addButtonsOfCattegoryOrTimetableTableView()
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
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

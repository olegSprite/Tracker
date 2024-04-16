//
//  CreateTracerViewController + Extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 10.04.2024.
//

import Foundation
import UIKit

// MARK: - TableViewDelegate

extension CreateTrackerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = CategoriesItCreactingViewController()
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true)
        } else {
            let vc = TimetableViewController()
            vc.delegate = self
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true)
        }
    }
}

// MARK: - TableViewDataSource

extension CreateTrackerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isTracer ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .black
        cell.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 235/255, alpha: 0.3)
        let text = indexPath.row == 0 ? "Категория" : "Расписание"
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        let subText = indexPath.row == 0 ? nil : returnTimetableToTableView()
        cell.detailTextLabel?.text = subText
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 17)
        cell.detailTextLabel?.textColor = UIColor(red: 174/255, green: 175/255, blue: 180/255, alpha: 1)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - TextFieldDelegate

extension CreateTrackerViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, !text.isEmpty {
            if text.count >= 1 && text.count <= 38 {
                textFieldСompleted = true
            } else {
                textFieldСompleted = false
            }
        }
        enabledSaveButtonOrNot()
        return true
    }
}

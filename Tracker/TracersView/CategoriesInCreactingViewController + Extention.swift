//
//  CategoriesInCreactingViewController + Extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 10.05.2024.
//

import Foundation
import UIKit

// MARK: - UITableViewDelegate

extension CategoriesInCreactingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.changeCategory(category: categories[indexPath.row])
        self.dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension CategoriesInCreactingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.textColor = .black
        cell.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 235/255, alpha: 0.3)
        let text = categories[indexPath.row].heading
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        cell.selectionStyle = .none
        if categories[indexPath.row] == curentCategory {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

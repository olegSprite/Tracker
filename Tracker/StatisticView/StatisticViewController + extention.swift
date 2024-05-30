//
//  StatisticViewController + extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 29.05.2024.
//

import Foundation
import UIKit

// MARK: - UITableViewDelegate

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableViewDataSource

extension StatisticViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatisticViewCell", for: indexPath) as? StatisticViewCell else {
            return UITableViewCell()
        }
        let count = stasisticService.completedTracersCount()
        cell.setupView(count: count, text: "Трекеров завершено")
        return cell
    }
}

//
//  TimetableViewController + Extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 13.04.2024.
//

import Foundation
import UIKit

// MARK: - TableViewDataSource

extension TimetableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = daysOfWeek[indexPath.row]
        cell.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 235/255, alpha: 0.3)
        let switchView = UISwitch()
        switchView.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        switchView.tag = indexPath.row
        cell.accessoryView = switchView
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

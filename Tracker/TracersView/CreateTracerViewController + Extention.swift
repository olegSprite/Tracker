//
//  CreateTracerViewController + Extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 10.04.2024.
//

import Foundation
import UIKit

extension CreateTracerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.row == 0 {
            let vc = CattegoriesItCreactingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = TimetableViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
     }
}

extension CreateTracerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isTracer ? 2 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .black
        cell.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 235/255, alpha: 0.3)
        let text = indexPath.row == 0 ? "Категория" : "Расписание"
        cell.textLabel?.text = text
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

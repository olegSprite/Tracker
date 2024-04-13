//
//  CattegoriesItCreactingViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 10.04.2024.
//

import Foundation
import UIKit

final class CattegoriesItCreactingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
    }
    
    private func setupNavBar() {
        title = "Категория"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

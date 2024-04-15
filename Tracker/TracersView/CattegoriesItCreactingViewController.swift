//
//  CattegoriesItCreactingViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 10.04.2024.
//

import Foundation
import UIKit

final class CattegoriesItCreactingViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        title = "Категория"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

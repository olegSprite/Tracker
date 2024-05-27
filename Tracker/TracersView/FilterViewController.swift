//
//  FilterViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 22.05.2024.
//

import Foundation
import UIKit

final class FilterViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let filtersTableView = UITableView()
    // MARK: - Public Properties
    
    let filtersName = ["Все трекеры", "Трекеры на сегодня", "Завершенные", "Не завершенные"]
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        addFiltersTableView()
    }
    // MARK: - Private Methods
    
    private func setupNavBar() {
        title = "Фильтры"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addFiltersTableView() {
        filtersTableView.dataSource = self
        filtersTableView.delegate = self
        filtersTableView.layer.masksToBounds = true
        filtersTableView.layer.cornerRadius = 16
        filtersTableView.isScrollEnabled = false
        filtersTableView.tableHeaderView = UIView()
        view.addSubview(filtersTableView)
        filtersTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filtersTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            filtersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filtersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filtersTableView.heightAnchor.constraint(equalToConstant: 299)
        ])
    }
    
    // MARK: - Public Methods
    // MARK: - Private Actions
    // MARK: - Public Actions
    
}

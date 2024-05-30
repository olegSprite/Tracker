//
//  StatisticViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import Foundation
import UIKit

final class StatisticViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let plugImage = UIImageView()
    private let plugLable = UILabel()
    
    // MARK: - Public Properties
    
    let statisticTableView = UITableView()
    var trackerRecordStore = TrackerRecordStore.shared
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trackerRecordStore.delegate = self
        view.backgroundColor = .white
        setupNavBar()
        if trackerRecordStore.trackerRecordCoreData.count != 0 {
            addStatisticTableView()
        } else {
            addPlug()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        title = "Статистика"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addPlug() {
        plugImage.image = UIImage(named: "cryEmoji")
        plugImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugImage)
        NSLayoutConstraint.activate([
            plugImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plugImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plugImage.widthAnchor.constraint(equalToConstant: 80),
            plugImage.heightAnchor.constraint(equalToConstant: 80)
        ])
        plugLable.text = "Анализировать пока нечего"
        plugLable.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        plugLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugLable)
        NSLayoutConstraint.activate([
            plugLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plugLable.topAnchor.constraint(equalTo: plugImage.bottomAnchor, constant: 8)
        ])
    }
    
    private func addStatisticTableView() {
        statisticTableView.dataSource = self
        statisticTableView.delegate = self
        statisticTableView.register(StatisticViewCell.self, forCellReuseIdentifier: "StatisticViewCell")
        statisticTableView.separatorStyle = .none
        statisticTableView.allowsSelection = false
        statisticTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statisticTableView)
        NSLayoutConstraint.activate([
            statisticTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            statisticTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            statisticTableView.heightAnchor.constraint(equalToConstant: 408)
        ])
    }
}

// MARK: - TrackerRecordStoreDelegate

extension StatisticViewController: TrackerRecordStoreDelegate {
    
    func updateCollection() {
        statisticTableView.reloadData()
    }
}

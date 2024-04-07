//
//  ViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import UIKit

final class TracersViewController: UIViewController {
    
    private let plugImageView = UIImageView()
    private let plugLable = UILabel()
    private var tracersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var tracers: [Tracker] = [Tracker(id: UUID.init(), name: "Это надпись для трекера", color: .red, emojy: "", timetable: .friday)]
    private var categories: [TrackerCategory] = []
    private var completedTrackers: [TrackerRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupNavBar()
        showPlugOrTracers()
    }
    
    private func setupNavBar() {
        title = "Трекеры"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: nil, action: nil)
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        
        let searchField = UISearchController(searchResultsController: nil)
        searchField.automaticallyShowsCancelButton = true
        self.navigationItem.searchController = searchField
    }
    
    private func showPlugOrTracers() {
        if tracers.isEmpty {
            addPlugImage()
            addPlugLable()
        } else {
            addTrecersCollectionView()
            setupTrecersCollectionView()
        }
    }
    
    private func addTrecersCollectionView() {
        tracersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tracersCollectionView)
        NSLayoutConstraint.activate([
            tracersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tracersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tracersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tracersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTrecersCollectionView() {
        self.tracersCollectionView.dataSource = self
        tracersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        tracersCollectionView.register(TracerViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func addPlugImage() {
        plugImageView.image = UIImage(named: "plugImage")
        plugImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugImageView)
        NSLayoutConstraint.activate([
            plugImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plugImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plugImageView.widthAnchor.constraint(equalToConstant: 80),
            plugImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func addPlugLable() {
        plugLable.text = "Что будем отслеживать?"
        plugLable.font = UIFont.systemFont(ofSize: 12)
        plugLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugLable)
        NSLayoutConstraint.activate([
            plugLable.topAnchor.constraint(equalTo: plugImageView.bottomAnchor, constant: 8),
            plugLable.centerXAnchor.constraint(equalTo: plugImageView.centerXAnchor)
        ])
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy" // Формат даты
        let formattedDate = dateFormatter.string(from: selectedDate)
        print("Выбранная дата: \(formattedDate)")
    }
}


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
    
    private var categories: [TrackerCategory] = [
        TrackerCategory(
            heading: "Животные",
            tracers: [
                Tracker(id: UUID.init(), name: "Пожрать и выпить пива с друзьями", color: .red, emojy: "🤣", timetable: [.friday]),
            ])
    ]
    var curentCategories = [TrackerCategory]()
    var completedTrackers: [TrackerRecord] = []
    private var curentDayOfWeak: Timetable = .none
    var currentDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        curentDayOfWeak = calculateDayOfWeak(date: Date())
        curentCategories = calculateArrayOfWeak(weak: curentDayOfWeak, categories: categories)
    }
    
    private func setupViews() {
        setupNavBar()
        showPlugOrTracers()
    }
    
    private func setupNavBar() {
        title = "Трекеры"
        navigationController?.navigationBar.prefersLargeTitles = true
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapPlusButtonOnNavBar))
        leftButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = leftButton
        
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        
        let searchField = UISearchController(searchResultsController: nil)
        searchField.automaticallyShowsCancelButton = true
        self.navigationItem.searchController = searchField
    }
    
    private func showPlugOrTracers() {
        if curentCategories.isEmpty {
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
            tracersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tracersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16)
        ])
    }
    
    private func setupTrecersCollectionView() {
        self.tracersCollectionView.dataSource = self
        self.tracersCollectionView.delegate = self
        tracersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        tracersCollectionView.register(TracerViewCell.self, forCellWithReuseIdentifier: "cell")
        tracersCollectionView.register(HeaderViewController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
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
    
    private func calculateDayOfWeak(date: Date) -> Timetable {
        let selectedDate = date
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: selectedDate)
        switch weekday {
        case 1:
            return .sunday
        case 2:
            return .monday
        case 3:
            return .tuesday
        case 4:
            return .wednesday
        case 5:
            return .thursday
        case 6:
            return .friday
        case 7:
            return .saturday
        default:
            print("Ошибка получения дня недели")
            return .none
        }
    }
    
    func calculateArrayOfWeak(weak: Timetable, categories: [TrackerCategory]) -> [TrackerCategory] {
        var resultArray = [TrackerCategory]()
        for category in categories {
            var resultTracersInCategory = [Tracker]()
            for tracer in category.tracers {
                for i in tracer.timetable {
                    if i == weak {
                        resultTracersInCategory.append(tracer)
                    }
                }
            }
            if !resultTracersInCategory.isEmpty {
                let resultOfCategory = TrackerCategory(heading: category.heading, tracers: resultTracersInCategory)
                resultArray.append(resultOfCategory)
            }
        }
        return resultArray
    }
    
    func calculateCountOfDayOnDate(tracer: Tracker, completedTrackers: [TrackerRecord], date: Date) -> Int {
        var result: Int = 0
        for i in completedTrackers {
            if i.id == tracer.id && i.date < date {
                result += 1
            }
        }
        return result
    }
    
    func completeTracerOnDateOrNot(tracer: Tracker, completedTrackers: [TrackerRecord], date: Date) -> Bool {
        var result = false
        for i in completedTrackers {
            if i.id == tracer.id && i.date == date {
                result = true
            }
        }
        return result
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        currentDate = sender.date
        curentDayOfWeak = calculateDayOfWeak(date: sender.date)
        curentCategories = calculateArrayOfWeak(weak: curentDayOfWeak, categories: categories)
        showPlugOrTracers()
        tracersCollectionView.reloadData()
    }
    
    @objc func didTapPlusButtonOnNavBar() {
        let vc = UINavigationController(rootViewController: HabitOrEventViewController())
        self.present(vc, animated: true)
    }
}


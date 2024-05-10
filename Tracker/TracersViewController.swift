//
//  ViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import UIKit

final class TrackersViewController: UIViewController, TrackerViewCellDelegate {
    
    // MARK: - Private Properties
    
    private let plugImageView = UIImageView()
    private let plugLable = UILabel()
    private var curentDayOfWeak: Timetable = .none
    private let trackerCategoryStore = TrackerCategoryStore.shared
    private let trackerStore = TrackerStore.shared
    
    // MARK: - Public Properties
    
    var categories = [TrackerCategory]()
    var trackersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    var curentCategories = [TrackerCategory]()
    var completedTrackers: [TrackerRecord] = []
    var currentDate: Date = Date()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        curentDayOfWeak = calculateDayOfWeak(date: Date())
        categories = returnCategories()
        curentCategories = calculateArrayOfWeak(weak: curentDayOfWeak, categories: categories)
        setupViews()
        trackerStore.delegate = self
    }
    
    // MARK: - Private Methods
    
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
        trackersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackersCollectionView)
        NSLayoutConstraint.activate([
            trackersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            trackersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            trackersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16)
        ])
    }
    
    private func setupTrecersCollectionView() {
        self.trackersCollectionView.dataSource = self
        self.trackersCollectionView.delegate = self
        trackersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        trackersCollectionView.register(TracerViewCell.self, forCellWithReuseIdentifier: "cell")
        trackersCollectionView.register(HeaderViewController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
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
    
    // MARK: - Public Methods
    
    func returnCategories() -> [TrackerCategory] {
        let trackersCategoryCoreData = trackerCategoryStore.trackersCategoryCoreData
        let trackersCoreData = trackerStore.trackersCoreData
        var result: [TrackerCategory] = []
        for trackerCategoryCoreData in trackersCategoryCoreData {
            var trackers: [Tracker] = []
            if let heading = trackerCategoryCoreData.heading {
                for trackerCoreData in trackersCoreData {
                        if trackerCoreData.category == trackerCategoryCoreData {
                            if
                                let id = trackerCoreData.id,
                                let name = trackerCoreData.name,
                                let color = trackerCoreData.color,
                                let emogi = trackerCoreData.emoji,
                                let timetable = trackerCoreData.timetable {
                            trackers.append(Tracker(
                                id: id,
                                name: name,
                                color: color as! UIColor,
                                emojy: emogi,
                                timetable: timetable as! [Timetable]))
                        }
                    }
                }
                result.append(TrackerCategory(
                    heading: heading,
                    tracers: trackers))
            }
        }
        return result
    }
    
    func calculateArrayOfWeak(weak: Timetable, categories: [TrackerCategory]) -> [TrackerCategory] {
        var resultArray = [TrackerCategory]()
        for category in categories {
            var resultTracersInCategory = [Tracker]()
            for tracer in category.tracers {
                for i in tracer.timetable {
                    if i == weak || i == .none {
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
            if i.id == tracer.id {
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
    
    func reloadCollectionAfterCreating() {
        categories = returnCategories()
        curentCategories = calculateArrayOfWeak(weak: curentDayOfWeak, categories: categories)
        showPlugOrTracers()
        trackersCollectionView.reloadData()
    }
    
    // MARK: - TrackerViewCellDelegate
    
    func writeCompletedTracker(tracker: Tracker) {
        let tracerRecord = TrackerRecord(id: tracker.id, date: currentDate)
        let oldCompletedTrackers = completedTrackers
        let newCompletedTrackers: [TrackerRecord] = [tracerRecord]
        completedTrackers = oldCompletedTrackers + newCompletedTrackers
    }
    
    func deleteCompletedTracer(tracker: Tracker) {
        let tracerRecord = TrackerRecord(id: tracker.id, date: currentDate)
        let oldCompletedTrackers = completedTrackers
        var newCompletedTrackers: [TrackerRecord] = [tracerRecord]
        for i in oldCompletedTrackers {
            if i.id != tracker.id {
                newCompletedTrackers.append(i)
            }
            if i.id == tracker.id && i.date != tracerRecord.date {
                newCompletedTrackers.append(i)
            }
        }
        completedTrackers = newCompletedTrackers
    }
    
    func deleteTracerFromCategories(tracker: Tracker) {
        var newCategories: [TrackerCategory] = []
        for category in categories {
            var resultTrackers: [Tracker] = []
            for i in category.tracers {
                if tracker.id != i.id {
                    resultTrackers.append(i)
                }
            }
            newCategories.append(TrackerCategory(heading: category.heading, tracers: resultTrackers))
        }
//        categories = newCategories
    }
    
    // MARK: - Private Actions
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        currentDate = sender.date
        curentDayOfWeak = calculateDayOfWeak(date: sender.date)
        curentCategories = calculateArrayOfWeak(weak: curentDayOfWeak, categories: categories)
        showPlugOrTracers()
        trackersCollectionView.reloadData()
    }
    
    @objc private func didTapPlusButtonOnNavBar() {
        let vc = HabitOrEventViewController()
        vc.originalViewController = self
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true)
    }
}


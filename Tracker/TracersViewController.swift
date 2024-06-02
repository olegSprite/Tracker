//
//  ViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let plugImageView = UIImageView()
    private let plugLable = UILabel()
    private var curentDayOfWeak: Timetable = .none
    private let filterButton = UIButton()
    private let datePicker = UIDatePicker()
    
    // MARK: - Public Properties
    
    var categories = [TrackerCategory]()
    var trackersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    var completedTrackers: [TrackerRecord] = []
    var currentDate: Date = Date()
    let trackerRecordStore = TrackerRecordStore.shared
    let trackerStore = TrackerStore.shared
    let trackerCategoryStore = TrackerCategoryStore.shared
    let analyticsService = AnalyticsService()
    var statisticViewController: StatisticViewController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "YPBackground")
        curentDayOfWeak = calculateDayOfWeak(date: Date())
        categories = returnCategories(filter: UserDefaults.standard.integer(forKey: "filter"))
        completedTrackers = returnCompletedTracers()
        setupViews()
        trackerStore.delegate = self
        analyticsService.report(event: "open", params: ["screen" : "Main"])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
     super.viewWillDisappear(animated)
        analyticsService.report(event: "close", params: ["screen" : "Main"])
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        setupNavBar()
        showPlugOrTracers()
    }
    
    private func setupNavBar() {
        let titleText = NSLocalizedString("trackers.title", comment: "Трекеры")
        title = titleText
        navigationController?.navigationBar.prefersLargeTitles = true
        let leftButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapPlusButtonOnNavBar))
        leftButton.tintColor = UIColor(named: "YPTextColor")
        self.navigationItem.leftBarButtonItem = leftButton
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)
        let searchField = UISearchController(searchResultsController: nil)
        searchField.automaticallyShowsCancelButton = true
        self.navigationItem.searchController = searchField
    }
    
    private func showPlugOrTracers() {
        if categories.isEmpty {
            addPlugImage()
            addPlugLable()
            filterButton.removeFromSuperview()
        } else {
            addTrecersCollectionView()
            setupTrecersCollectionView()
            addFilterButton()
        }
    }
    
    private func addTrecersCollectionView() {
        trackersCollectionView.backgroundColor = UIColor(named: "YPBackground")
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
        self.trackersCollectionView.allowsMultipleSelection = false
        trackersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        trackersCollectionView.register(TracerViewCell.self, forCellWithReuseIdentifier: "cell")
        trackersCollectionView.register(HeaderViewController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        trackersCollectionView.register(FooterViewController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
    }
    
    private func addFilterButton() {
        let filterText = NSLocalizedString("filters", comment: "Фильтры")
        filterButton.setTitle(filterText, for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonTap), for: .touchUpInside)
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        if UserDefaults.standard.integer(forKey: "filter") == 0 {
            filterButton.tintColor = .white
        } else {
            filterButton.tintColor = .red
        }
        filterButton.backgroundColor = UIColor(red: 55/255, green: 114/255, blue: 231/255, alpha: 1)
        filterButton.layer.masksToBounds = true
        filterButton.layer.cornerRadius = 16
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterButton)
        NSLayoutConstraint.activate([
            filterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            filterButton.heightAnchor.constraint(equalToConstant: 50),
            filterButton.widthAnchor.constraint(equalToConstant: 114)
        ])
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
        if trackerStore.trackersCoreData.isEmpty {
            plugLable.text = "Что будем отслеживать?"
        } else {
            plugLable.text = "Ничего не найдено"
        }
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
    
    func returnCategories(filter: Int) -> [TrackerCategory] {
        let trackersCategoryCoreData = trackerCategoryStore.trackersCategoryCoreData
        let trackersCoreData = trackerStore.trackersCoreData
        var result: [TrackerCategory] = []
        let currentDate = datePicker.date
        let weak = calculateDayOfWeak(date: currentDate)
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
                            
                            let tracker = Tracker(
                                id: id,
                                name: name,
                                color: color as! UIColor,
                                emojy: emogi,
                                timetable: timetable as! [Timetable]
                            )
                            
                            let isCompletedToday = completedTrackers.contains { $0.id == id && Calendar.current.isDate($0.date, inSameDayAs: currentDate) }
                            let isNotCompletedToday = !isCompletedToday
                            let isCompletedAnyDay = completedTrackers.contains { $0.id == id }
                            
                            switch filter {
                            case 0:
                                for trackerWeak in tracker.timetable {
                                    if trackerWeak == weak {
                                        trackers.append(tracker)
                                    }
                                    if trackerWeak == .none {
                                        if isCompletedAnyDay && isCompletedToday {
                                            trackers.append(tracker)
                                        }
                                        if !isCompletedAnyDay {
                                            trackers.append(tracker)
                                        }
                                    }
                                }
                            case 1:
                                datePicker.date = Date()
                                for trackerWeak in tracker.timetable {
                                    if trackerWeak == weak {
                                        trackers.append(tracker)
                                    }
                                    if trackerWeak == .none {
                                        if isCompletedAnyDay && isCompletedToday {
                                            trackers.append(tracker)
                                        }
                                        if !isCompletedAnyDay {
                                            trackers.append(tracker)
                                        }
                                    }
                                }
                            case 2:
                                if isCompletedToday {
                                    for trackerWeak in tracker.timetable {
                                        if trackerWeak == weak || trackerWeak == .none {
                                            trackers.append(tracker)
                                        }
                                    }
                                }
                            case 3:
                                if isNotCompletedToday {
                                    for trackerWeak in tracker.timetable {
                                        if trackerWeak == weak {
                                            trackers.append(tracker)
                                        }
                                        if trackerWeak == .none {
                                            if isCompletedAnyDay && isCompletedToday {
                                                trackers.append(tracker)
                                            }
                                            if !isCompletedAnyDay {
                                                trackers.append(tracker)
                                            }
                                        }
                                    }
                                }
                            default:
                                for trackerWeak in tracker.timetable {
                                    if trackerWeak == weak || trackerWeak == .none {
                                        trackers.append(tracker)
                                    }
                                }
                            }
                        }
                    }
                }
                if !trackers.isEmpty {
                    result.append(TrackerCategory(
                        heading: heading,
                        tracers: trackers))
                }
            }
        }
        return result
    }
    
    func returnCompletedTracers() -> [TrackerRecord] {
        guard let trackersRecordCoreData = trackerRecordStore.fetchTrackerRecord() else { return [] }
        var result: [TrackerRecord] = []
        for trackerRecordCoreData in trackersRecordCoreData {
            if let trackerId = trackerRecordCoreData.id, let trackerRecordDate = trackerRecordCoreData.date {
                result.append(TrackerRecord(id: trackerId, date: trackerRecordDate))
            }
        }
        return result
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
            let componentsDate1 = Calendar.current.dateComponents([.year, .month, .day], from: i.date)
            let componentsDate2 = Calendar.current.dateComponents([.year, .month, .day], from: date)
            if i.id == tracer.id && componentsDate1 == componentsDate2 {
                result = true
            }
        }
        return result
    }
    
    func reloadCollectionAfterCreating() {
        categories = returnCategories(filter: UserDefaults.standard.integer(forKey: "filter"))
        showPlugOrTracers()
        trackersCollectionView.reloadData()
    }
    
    func reloadCollection() {
        categories = returnCategories(filter: UserDefaults.standard.integer(forKey: "filter"))
        showPlugOrTracers()
        trackersCollectionView.reloadData()
    }
    
    func isTrackerOrNot(tracker: Tracker) -> Bool {
        if tracker.timetable.first == Timetable.none { return false } else { return true }
    }
    
    // MARK: - Private Actions
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        currentDate = sender.date
        curentDayOfWeak = calculateDayOfWeak(date: sender.date)
        let filter = UserDefaults.standard.integer(forKey: "filter")
        if filter == 1 {
            categories = returnCategories(filter: 0)
        } else {
           categories = returnCategories(filter: filter)
        }
        showPlugOrTracers()
        trackersCollectionView.reloadData()
    }
    
    @objc private func didTapPlusButtonOnNavBar() {
        let vc = HabitOrEventViewController()
        vc.originalViewController = self
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true)
        analyticsService.report(event: "click", params: ["screen" : "Main", "item" : "add_track"])
    }
    
    @objc private func filterButtonTap() {
        let vc = FilterViewController()
        vc.vc = self
        let navBarVC = UINavigationController(rootViewController: vc)
        self.present(navBarVC, animated: true)
        analyticsService.report(event: "click", params: ["screen" : "Main", "item" : "filter"])
    }
}


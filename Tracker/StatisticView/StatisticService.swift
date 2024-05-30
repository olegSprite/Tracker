//
//  StatisticService.swift
//  Tracker
//
//  Created by Олег Спиридонов on 29.05.2024.
//

import Foundation

final class StatisticService {
    
    // MARK: - Private Properties
    
    private let trackerRecordStore = TrackerRecordStore.shared
    
    // MARK: - Public Properties
    // MARK: - Lifecycle
    // MARK: - Private Methods
    // MARK: - Public Methods
    
    func completedTracersCount() -> Int {
        guard let trackerRecordCoreData = trackerRecordStore.fetchTrackerRecord() else { return 0 }
        return trackerRecordCoreData.count
    }
    
    // MARK: - Private Actions
    // MARK: - Public Actions
}

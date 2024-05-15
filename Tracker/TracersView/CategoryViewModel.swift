//
//  CategoryViewModel.swift
//  Tracker
//
//  Created by Олег Спиридонов on 14.05.2024.
//

import Foundation

typealias Binding<T> = (T) -> Void

final class CategoryViewModel {
    
    // MARK: - Private Properties
    
    private let trackerCategoryStore = TrackerCategoryStore.shared
    
    // MARK: - Public Properties
    
    var curentCategory: Binding<TrackerCategoryCoreData>?
    var categoryes: Binding<[TrackerCategoryCoreData]>?
    var createTrackerViewController: CreateTrackerViewController?
    
    // MARK: - Public Methods
    
    func fetchTrackerCategory() {
        self.categoryes?(trackerCategoryStore.trackersCategoryCoreData)
        self.trackerCategoryStore.delegate = self
    }
    
    func saveCategoryAndReturnToScreen(category: TrackerCategoryCoreData) {
        createTrackerViewController?.categoryCoreData = category
        createTrackerViewController?.buttonsOfCattegoryOrTimetableTableView.reloadData()
        createTrackerViewController?.enabledSaveButtonOrNot()
    }
}

// MARK: - TrackerCategoryStoreDelegate

extension CategoryViewModel: TrackerCategoryStoreDelegate {
    func updateCategorys() {
        fetchTrackerCategory()
    }
}

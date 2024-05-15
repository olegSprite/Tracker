//
//  CategoryViewModel.swift
//  Tracker
//
//  Created by Олег Спиридонов on 14.05.2024.
//

import Foundation

typealias Binding<T> = (T) -> Void

final class CategoryViewModel {
    
    var curentCategory: Binding<TrackerCategoryCoreData>?
    var categoryes: Binding<[TrackerCategoryCoreData]>?
    private let trackerCategoryStore = TrackerCategoryStore.shared
    var createTrackerViewController: CreateTrackerViewController?
    
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

extension CategoryViewModel: TrackerCategoryStoreDelegate {
    func updateCategorys() {
        fetchTrackerCategory()
    }
}

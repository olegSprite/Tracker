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
    
    // MARK: - Public Methods
    
    func fetchTrackerCategory() {
        self.categoryes?(trackerCategoryStore.trackersCategoryCoreData)
        self.trackerCategoryStore.delegate = self
    }
    
    func changeCategory(category: TrackerCategoryCoreData) {
        curentCategory?(category)
    }
}

// MARK: - TrackerCategoryStoreDelegate

extension CategoryViewModel: TrackerCategoryStoreDelegate {
    func updateCategorys() {
        fetchTrackerCategory()
    }
}

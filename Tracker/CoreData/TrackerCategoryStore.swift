//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Олег Спиридонов on 28.04.2024.
//

import UIKit
import CoreData

final class TrackerCategoryStore: NSObject {
    
    static let shared = TrackerCategoryStore()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Create
    
    func createTracerCategory(heading: String) -> TrackerCategoryCoreData? {
        guard let tracerCategoryEntityDescription = NSEntityDescription.entity(forEntityName: "TrackerCategoryCoreData", in: context) else { return nil }
        let tracerCategoryEntity = TrackerCategoryCoreData(entity: tracerCategoryEntityDescription, insertInto: context)
        tracerCategoryEntity.heading = heading
        appDelegate.saveContext()
        return tracerCategoryEntity
    }
    
    // MARK: - Read
    
    func fetchTrackerCategoryCoreData(heading: String) -> TrackerCategoryCoreData? {
        let fetchRequest = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "heading == %@", heading)
        do {
            let category = try context.fetch(fetchRequest)
            return category.first
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func fetchTrackersCategory() -> [TrackerCategoryCoreData] {
       let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        guard let trackerCategoryCoreData = try? context.fetch(request) else { return [] }
        return trackerCategoryCoreData
    }
}

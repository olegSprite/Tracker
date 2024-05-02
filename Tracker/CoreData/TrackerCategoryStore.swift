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
    
    func createTracerCategory(heading: String) {
        guard let tracerCategoryEntityDescription = NSEntityDescription.entity(forEntityName: "TrackerCategoryCoreData", in: context) else { return }
        let tracerCategoryEntity = TrackerCategoryCoreData(entity: tracerCategoryEntityDescription, insertInto: context)
        tracerCategoryEntity.heading = heading
        appDelegate.saveContext()
    }
    
    // MARK: - Read
    
    func fetchTracerCategory() -> [TrackerCategory] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TrackerCategoryCoreData")
        do {
            return try context.fetch(fetchRequest) as! [TrackerCategory]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}

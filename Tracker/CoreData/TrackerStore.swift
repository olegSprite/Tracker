//
//  TrackerStore.swift
//  Tracker
//
//  Created by Олег Спиридонов on 28.04.2024.
//

import CoreData
import UIKit

final class TrackerStore: NSObject {
    
    static let shared = TrackerStore()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Create
    
    func saveTracer(tracer: Tracker, category: TrackerCategoryCoreData) {
        guard let tracerEntityDescription = NSEntityDescription.entity(forEntityName: "TrackerCoreData", in: context) else { return }
        let tracerEntity = TrackerCoreData(entity: tracerEntityDescription, insertInto: context)
        tracerEntity.color = tracer.color
        tracerEntity.emoji = tracer.emojy
        tracerEntity.id = tracer.id
        tracerEntity.name = tracer.name
        tracerEntity.timetable = tracer.timetable as NSObject
        tracerEntity.category = category
        appDelegate.saveContext()
    }
}

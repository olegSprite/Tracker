//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Олег Спиридонов on 28.04.2024.
//

import Foundation
import CoreData

final class TrackerRecordStore: NSObject {
    
    // MARK: - Private Properties
    
    private override init() {}
    private var persistentContainerCreator = PersistentContainerCreator.shared
    private var context: NSManagedObjectContext {
        persistentContainerCreator.persistentContainer.viewContext
    }
    // MARK: - Public Properties
    
    static let shared = TrackerRecordStore()
    
    // MARK: - Create
    
    func createTrackerRecord(tracker: Tracker, date: Date) {
        guard let trackerRecordCEntityDescription = NSEntityDescription.entity(forEntityName: "TrackerRecordCoreData", in: context) else { return }
        let trackerRecordEntity = TrackerRecordCoreData(entity: trackerRecordCEntityDescription, insertInto: context)
        trackerRecordEntity.id = tracker.id
        trackerRecordEntity.date = date
        persistentContainerCreator.saveContext()
    }
    
    // MARK: - Delete
    
    func deleteTrackerRecord(tracker: Tracker, date: Date) {
        guard let trackerRecordCoreData = fetchTrackerRecord(tracker: tracker, date: date) else { return }
        for tracaerRecord in trackerRecordCoreData {
            context.delete(tracaerRecord)
        }
        persistentContainerCreator.saveContext()
    }
    
    // MARK: - Read
    
    func fetchTrackerRecord() -> [TrackerRecordCoreData]? {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Ошибка при выполнении запроса: \(error)")
            return nil
        }
    }
    
    func fetchTrackerRecord(tracker: Tracker, date: Date) -> [TrackerRecordCoreData]? {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        let firstPredicate = NSPredicate(format: "id == %@", argumentArray: [tracker.id])
        let secondPredicate = NSPredicate(format: "date == %@", argumentArray: [date])
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [firstPredicate, secondPredicate])
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Ошибка при выполнении запроса: \(error)")
            return nil
        }
    }
}

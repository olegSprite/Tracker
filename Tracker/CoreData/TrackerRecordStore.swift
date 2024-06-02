//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Олег Спиридонов on 28.04.2024.
//

import Foundation
import CoreData

protocol TrackerRecordStoreDelegate: AnyObject {
    func updateCollection()
}

final class TrackerRecordStore: NSObject {
    
    // MARK: - Private Properties
    
    private override init() {}
    private var persistentContainerCreator = PersistentContainerCreator.shared
    private var context: NSManagedObjectContext {
        persistentContainerCreator.persistentContainer.viewContext
    }
    // MARK: - Public Properties
    
    static let shared = TrackerRecordStore()
    
    var trackerRecordCoreData: [TrackerRecordCoreData] {
        guard let objects = self.fetchedResultsController.fetchedObjects else { return [] }
        return objects
    }
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TrackerRecordCoreData> = {
        let fetchRequest = TrackerRecordCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "id", ascending: false)
        ]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }()
    weak var delegate: TrackerRecordStoreDelegate?
    
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

// MARK: - NSFetchedResultsControllerDelegate

extension TrackerRecordStore: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        delegate?.updateCollection()
    }
}

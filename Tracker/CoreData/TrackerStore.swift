//
//  TrackerStore.swift
//  Tracker
//
//  Created by Олег Спиридонов on 28.04.2024.
//

import CoreData
import UIKit

protocol TrackerStoreDelegate: AnyObject {
    func updateCollection()
}

final class TrackerStore: NSObject {
    
    static let shared = TrackerStore()
    private override init() { }
    private var persistentContainerCreator = PersistentContainerCreator.shared
    private var context: NSManagedObjectContext {
        persistentContainerCreator.persistentContainer.viewContext
    }
    var trackersCoreData: [TrackerCoreData] {
        guard let objects = self.fetchedResultsController.fetchedObjects else { return [] }
        return objects
    }
    private lazy var fetchedResultsController: NSFetchedResultsController<TrackerCoreData> = {
        let fetchRequest = TrackerCoreData.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: false)
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
    weak var delegate: TrackerStoreDelegate?
    private let trackerCategoryStore = TrackerCategoryStore.shared
    
    // MARK: - Create
    
    func saveTracer(tracker: Tracker, category: TrackerCategoryCoreData) {
        guard let tracerEntityDescription = NSEntityDescription.entity(forEntityName: "TrackerCoreData", in: context) else { return }
        let tracerEntity = TrackerCoreData(entity: tracerEntityDescription, insertInto: context)
        tracerEntity.color = tracker.color
        tracerEntity.emoji = tracker.emojy
        tracerEntity.id = tracker.id
        tracerEntity.name = tracker.name
        tracerEntity.timetable = tracker.timetable as NSObject
        category.addToTrackers(tracerEntity)
        persistentContainerCreator.saveContext()
    }
    
    // MARK: - Read
    
    func fetchTrackers() -> [TrackerCoreData] {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        guard let trackersCoreData = try? context.fetch(request) else { return [] }
        return trackersCoreData
    }
    
    func fetchTracker(tracker: Tracker) -> [TrackerCoreData]? {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.predicate = NSPredicate(format: "id == %@", argumentArray: [tracker.id])
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request)
            return result
        } catch {
            print("Ошибка при выполнении запроса: \(error)")
            return nil
        }
    }
    
    // MARK: - Update
    
    func updateTracker(oldTracker: Tracker, newTracker: Tracker, category: TrackerCategoryCoreData) {
        let trackerCoreData = fetchTracker(tracker: oldTracker)?[0]
        trackerCoreData?.id = newTracker.id
        trackerCoreData?.name = newTracker.name
        trackerCoreData?.category = category
        trackerCoreData?.color = newTracker.color
        trackerCoreData?.emoji = newTracker.emojy
        trackerCoreData?.timetable = newTracker.timetable as NSObject
        persistentContainerCreator.saveContext()
    }
    
    func fixedTracker(tracker: Tracker, category: TrackerCategoryCoreData) {
        let trackerCoreData = fetchTracker(tracker: tracker)?[0]
        trackerCoreData?.oldCategory = trackerCoreData?.category?.heading
        trackerCoreData?.category = category
        persistentContainerCreator.saveContext()
    }
    
    func unfixedTracker(tracker: Tracker) {
        let trackerCoreData = fetchTracker(tracker: tracker)?[0]
        guard let oldCategory = trackerCoreData?.oldCategory else { return }
        trackerCoreData?.category = trackerCategoryStore.fetchTrackerCategoryCoreData(heading: oldCategory)
        trackerCoreData?.oldCategory = nil
        persistentContainerCreator.saveContext()
    }
    
    // MARK: - Delete
    
    func deleteTracker(tracker: Tracker) {
        guard let tracker = fetchTracker(tracker: tracker) else { return }
        context.delete(tracker[0])
        persistentContainerCreator.saveContext()
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TrackerStore: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        delegate?.updateCollection()
    }
}

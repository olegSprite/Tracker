//
//  Extention TracersViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 07.04.2024.
//

import Foundation
import UIKit

// MARK: - CollectionViewDataSource

extension TrackersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].tracers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TracerViewCell else { return UICollectionViewCell() }
        let tracer = categories[indexPath.section].tracers[indexPath.row]
        cell.selectedDate = currentDate
        cell.tracerViewController = self
        cell.daysCount = calculateCountOfDayOnDate(tracer: tracer, completedTrackers: completedTrackers, date: currentDate)
        cell.tracerChengeToday = completeTracerOnDateOrNot(tracer: tracer, completedTrackers: completedTrackers, date: currentDate)
        cell.currentTracer(tracer: tracer)
        var fixed = false
        if trackerStore.fetchTracker(tracker: tracer)?[0].oldCategory != nil {
            fixed = true
        }
        cell.fixed = fixed
        cell.setupViews(tracker: tracer)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HeaderViewController else { return UICollectionReusableView() }
            view.titleLabel.text = categories[indexPath.section].heading
            return view
        } else if kind == UICollectionView.elementKindSectionFooter && indexPath.section == collectionView.numberOfSections - 1 {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! FooterViewController
            return footer
        }
        return UICollectionReusableView()
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: 148)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == collectionView.numberOfSections - 1 {
            return CGSize(width: collectionView.frame.width, height: 75)
        }
        return CGSize.zero
    }
}
// MARK: - CollectionViewDelegate

extension TrackersViewController: UICollectionViewDelegate { }
// MARK: - TrackerStoreDelegate

extension TrackersViewController: TrackerStoreDelegate {
    
    func updateCollection() {
        reloadCollectionAfterCreating()
    }
}

// MARK: - TrackerViewCellDelegate

extension TrackersViewController: TrackerViewCellDelegate {
    
    func writeCompletedTracker(tracker: Tracker, date: Date) {
        trackerRecordStore.createTrackerRecord(tracker: tracker, date: date)
        completedTrackers = returnCompletedTracers()
    }
    
    func deleteCompletedTracer(tracker: Tracker, date: Date) {
        trackerRecordStore.deleteTrackerRecord(tracker: tracker, date: date)
        completedTrackers = returnCompletedTracers()
    }
    
    func returnContextMenu(cell: TracerViewCell) -> UIContextMenuConfiguration? {
        guard let indexPath = trackersCollectionView.indexPath(for: cell) else { return nil }
        let tracer = categories[indexPath.section].tracers[indexPath.row]
        guard let categoryCoreData = (trackerStore.fetchTracker(tracker: tracer)?[0].category) else { return nil }
        var fixed = false
        if trackerStore.fetchTracker(tracker: tracer)?[0].oldCategory != nil {
            fixed = true
        }
        let daysCount = calculateCountOfDayOnDate(tracer: tracer, completedTrackers: completedTrackers, date: currentDate)
        return UIContextMenuConfiguration(actionProvider:  { actions in
            return UIMenu(children: [
                UIAction(title: fixed ? "Открепить" : "Закрепить") { [weak self] _ in
                    if fixed {
                        self?.trackerStore.unfixedTracker(tracker: tracer)
                        self?.trackersCollectionView.reloadData()
                    } else {
                        if self?.trackerCategoryStore.fetchTrackerCategoryCoreData(heading: "Закрепленные") == nil {
                            guard let category = self?.trackerCategoryStore.createTracerCategory(heading: "Закрепленные") else { return }
                            self?.trackerStore.fixedTracker(tracker: tracer, category: category)
                            self?.trackersCollectionView.reloadData()
                        } else {
                            guard let category = self?.trackerCategoryStore.fetchTrackerCategoryCoreData(heading: "Закрепленные") else { return }
                            self?.trackerStore.fixedTracker(tracker: tracer, category: category)
                            self?.trackersCollectionView.reloadData()
                        }
                    }
                },
                UIAction(title: "Редактировать") { [weak self] _ in
                    let vc = EditingTrackerViewController(tracker: tracer,
                                                          isTracker: self?.isTrackerOrNot(tracker: tracer) ?? false,
                                                          categoryCoreData: categoryCoreData,
                                                          timetable: Set(tracer.timetable),
                                                          daysCount: daysCount)
                    let navVC = UINavigationController(rootViewController: vc)
                    self?.present(navVC, animated: true)
                    self?.analyticsService.report(event: "click", params: ["screen" : "Main", "item" : "edit"])
                },
                UIAction(title: "Удалить", attributes: .destructive) { [weak self] _ in
                    self?.trackerStore.deleteTracker(tracker: tracer)
                    self?.trackersCollectionView.reloadData()
                    self?.analyticsService.report(event: "click", params: ["screen" : "Main", "item" : "delete"])
                }
            ])
        })
    }
}



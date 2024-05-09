//
//  Extention TracersViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 07.04.2024.
//

import Foundation
import UIKit
import CoreData

// MARK: - CollectionViewDataSource

extension TrackersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        curentCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return curentCategories[section].tracers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TracerViewCell else { return UICollectionViewCell() }
        let tracer = curentCategories[indexPath.section].tracers[indexPath.row]
        cell.selectedDate = currentDate
        cell.tracerViewController = self
        cell.daysCount = calculateCountOfDayOnDate(tracer: tracer, completedTrackers: completedTrackers, date: currentDate)
        cell.tracerChengeToday = completeTracerOnDateOrNot(tracer: tracer, completedTrackers: completedTrackers, date: currentDate)
        cell.currentTracer(tracer: tracer)
        cell.setupViews(tracker: tracer)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HeaderViewController else { return  UICollectionReusableView()}
        view.titleLabel.text = curentCategories[indexPath.section].heading
        return view
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
}

//extension TrackersViewController: NSFetchedResultsControllerDelegate {
//    
//}



//
//  TracerViewCell.swift
//  Tracker
//
//  Created by Олег Спиридонов on 07.04.2024.
//

import Foundation
import UIKit

protocol TrackerViewCellDelegate: AnyObject {
    func writeCompletedTracker(tracker: Tracker, date: Date)
    func deleteCompletedTracer(tracker: Tracker, date: Date)
}

final class TracerViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let nameLable = UILabel()
    private let emogiImage = UILabel()
    private let daysCountLable = UILabel()
    private let completeButton = UIButton()
    private var background = UIView()
    private let currentDate = Date()
    private let fixPin = UIImageView()
    private var currentTracer: Tracker?
    private let analyticsService = AnalyticsService()
    
    // MARK: - Public Properties
    
    var daysCount: Int = 0
    var tracerChengeToday = false
    var fixed = false
    var selectedDate = Date()
    var tracerViewController: TrackersViewController?
    weak var delegate: TrackerViewCellDelegate?
    
    // MARK: - Public Methods
    
    func setupViews(tracker: Tracker) {
        createBackground(color: tracker.color)
        addName(name: tracker.name)
        addEmoji(emoji: tracker.emojy)
        addCompleteButton(color: tracker.color)
        addDaysCountLable()
        addFixPin()
    }
    
    func currentTracer(tracer: Tracker) {
        currentTracer = tracer
    }
    
    // MARK: - Private Methods
    
    private func createBackground(color: UIColor) {
        background.translatesAutoresizingMaskIntoConstraints = false
        addSubview(background)
        background.backgroundColor = color
        NSLayoutConstraint.activate([
            background.widthAnchor.constraint(equalToConstant: 167),
            background.heightAnchor.constraint(equalToConstant: 90),
        ])
        background.layer.cornerRadius = 16
    }
    
    private func addName(name: String) {
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        nameLable.text = name
        nameLable.font = UIFont.systemFont(ofSize: 12)
        nameLable.textColor = .white
        nameLable.lineBreakMode = .byWordWrapping
        nameLable.textAlignment = .left
        nameLable.numberOfLines = 2
        addSubview(nameLable)
        NSLayoutConstraint.activate([
            nameLable.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 12),
            nameLable.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -12),
            nameLable.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -12)
        ])
    }
    
    private func addEmoji(emoji: String) {
        emogiImage.translatesAutoresizingMaskIntoConstraints = false
        emogiImage.text = emoji
        emogiImage.font = UIFont.systemFont(ofSize: 16)
        emogiImage.textAlignment = .center
        emogiImage.backgroundColor = .white.withAlphaComponent(0.3)
        emogiImage.layer.masksToBounds = true
        emogiImage.layer.cornerRadius = 12
        addSubview(emogiImage)
        NSLayoutConstraint.activate([
            emogiImage.leadingAnchor.constraint(equalTo: nameLable.leadingAnchor),
            emogiImage.heightAnchor.constraint(equalToConstant: 24),
            emogiImage.widthAnchor.constraint(equalToConstant: 24),
            emogiImage.topAnchor.constraint(equalTo: background.topAnchor, constant: 12)
        ])
    }
    
    private func addFixPin() {
        if fixed {
            fixPin.image = UIImage(systemName: "pin.fill")
            fixPin.tintColor = .white
            fixPin.translatesAutoresizingMaskIntoConstraints = false
            addSubview(fixPin)
            NSLayoutConstraint.activate([
                fixPin.heightAnchor.constraint(equalToConstant: 12),
                fixPin.widthAnchor.constraint(equalToConstant: 12),
                fixPin.topAnchor.constraint(equalTo: background.topAnchor, constant: 18),
                fixPin.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10)
            ])
        }
    }
    
    private func addDaysCountLable() {
        daysCountLable.translatesAutoresizingMaskIntoConstraints = false
        setupDaysCount(newCount: daysCount)
        daysCountLable.font = UIFont.systemFont(ofSize: 12)
        addSubview(daysCountLable)
        NSLayoutConstraint.activate([
            daysCountLable.leadingAnchor.constraint(equalTo: nameLable.leadingAnchor),
            daysCountLable.centerYAnchor.constraint(equalTo: completeButton.centerYAnchor),
            
        ])
    }
    
    private func addCompleteButton(color: UIColor) {
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.backgroundColor = color
        completeButton.layer.cornerRadius = 16
        if tracerChengeToday == false {
            tracerNoCompleteToday()
        } else {
            tracerCompleteToday()
        }
        completeButton.tintColor = UIColor(named: "YPBackground")
        completeButton.addTarget(self, action: #selector(didTapCompleteButton), for: .touchUpInside)
        addSubview(completeButton)
        NSLayoutConstraint.activate([
            completeButton.topAnchor.constraint(equalTo: background.bottomAnchor, constant: 8),
            completeButton.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -12),
            completeButton.widthAnchor.constraint(equalToConstant: 34),
            completeButton.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupDaysCount(newCount: Int) {
        let dayText = NSLocalizedString("day", comment: "день")
        let daysText = NSLocalizedString("days", comment: "дней")
        switch newCount{
        case 1:
            daysCountLable.text = "\(newCount) \(dayText)"
        default:
            daysCountLable.text = "\(newCount) \(daysText)"
        }
    }
    
    private func plusDaysCount() {
        let newCount = daysCount + 1
        tracerChengeToday = true
        setupDaysCount(newCount: newCount)
        daysCount = newCount
        tracerCompleteToday()
    }
    
    private func minesDaysCount() {
        let newCount = daysCount - 1
        tracerChengeToday = false
        setupDaysCount(newCount: newCount)
        daysCount = newCount
        tracerNoCompleteToday()
    }
    
    private func tracerCompleteToday() {
        completeButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        completeButton.backgroundColor = completeButton.backgroundColor?.withAlphaComponent(0.3)
    }
    
    private func tracerNoCompleteToday() {
        completeButton.setImage(UIImage(systemName: "plus"), for: .normal)
        completeButton.backgroundColor = completeButton.backgroundColor?.withAlphaComponent(1)
    }
    
    private func writeCompletedTracker() {
        guard let tracer = currentTracer else { return }
        delegate?.writeCompletedTracker(tracker: tracer, date: selectedDate)
    }
    
    private func deleteCompletedTracer() {
        guard let tracer = currentTracer else { return }
        delegate?.deleteCompletedTracer(tracker: tracer, date: selectedDate)
    }
    
    // MARK: - Private Actions
    
    @objc private func didTapCompleteButton() {
        guard currentDate > selectedDate else { return }
        if tracerChengeToday == false {
            plusDaysCount()
            writeCompletedTracker()
        } else {
            minesDaysCount()
            deleteCompletedTracer()
        }
        analyticsService.report(event: "click", params: ["screen" : "Main", "item" : "track"])
    }
}


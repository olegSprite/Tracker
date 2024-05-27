//
//  EditingTrackerViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 21.05.2024.
//

import Foundation
import UIKit

final class EditingTrackerViewController: CreateTrackerViewController {
    
    // MARK: - Private Properties
    
    private let daysCountLable = UILabel()
    private var curentTracker: Tracker? = nil
    private var daysCount: Int = 0
    
    // MARK: - Public Properties
    
    // MARK: - Lifecycle
    
    init(tracker: Tracker, isTracker: Bool, categoryCoreData: TrackerCategoryCoreData, timetable: Set<Timetable>, daysCount: Int) {
        super.init(nibName: nil, bundle: nil)
        self.curentTracker = tracker
        self.isTracer = isTracker
        self.categoryCoreData = categoryCoreData
        self.timetable = timetable
        self.daysCount = daysCount
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTracerTextField.text = curentTracker?.name
        setupDaysCount(count: daysCount)
        if let tracker = curentTracker {
            setupSelectedCell(tracker: tracker)
        }
    }
    // MARK: - Override Methods
    
    override func setupNavBar() {
        title = "Редактирование привычки"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func addViews() {
        addDaysCount()
        super.addViews()
    }
    
    override func addNameTracerTextField() {
        nameTracerTextField.delegate = self
        nameTracerTextField.placeholder = "Введите название трекера"
        nameTracerTextField.clearButtonMode = .whileEditing
        nameTracerTextField.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 235/255, alpha: 0.3)
        nameTracerTextField.layer.masksToBounds = true
        nameTracerTextField.layer.cornerRadius = 16
        nameTracerTextField.setLeftPaddingPoints(16)
        contentView.addSubview(nameTracerTextField)
        nameTracerTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTracerTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTracerTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTracerTextField.heightAnchor.constraint(equalToConstant: 75),
            nameTracerTextField.topAnchor.constraint(equalTo: daysCountLable.bottomAnchor, constant: 24)
        ])
    }
    
    override func addSaveButton() {
        super.addSaveButton()
        saveButton.setTitle("Сохранить", for: .normal)
    }
    
    // MARK: - Private Method
    
    private func addDaysCount() {
        daysCountLable.text = "5 дней"
        daysCountLable.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        daysCountLable.textColor = .black
        daysCountLable.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(daysCountLable)
        NSLayoutConstraint.activate([
            daysCountLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            daysCountLable.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    private func setupDaysCount(count: Int) {
        switch count{
        case 1:
            daysCountLable.text = "\(count) день"
        case 2...4:
            daysCountLable.text = "\(count) дня"
        default:
            daysCountLable.text = "\(count) дней"
        }
    }
    
    private func setupSelectedCell(tracker: Tracker) {
        var indexPathEmojy = IndexPath.init(row: 0, section: 0)
        var indexPathColor = IndexPath.init(row: 0, section: 1)
        for emoji in emojis {
            if emoji != tracker.emojy {
                indexPathEmojy.row += 1
            } else {
                break
            }
        }
        for color in colors {
            if color != tracker.color {
                indexPathColor.row += 1
            } else {
                break
            }
        }
        guard let emojiCell = emogiAndColorCollectionView.cellForItem(at: indexPathEmojy) as? EmogiAndColorCell else { return }
        guard let colorCell = emogiAndColorCollectionView.cellForItem(at: indexPathColor) as? EmogiAndColorCell else { return }
        emojiCell.selectEmogiCell()
        colorCell.selectColorCell()
        selectedEmogi = tracker.emojy
        selectedColor = tracker.color
    }
    
    // MARK: - Override Action
    
    @objc override func tapSaveButton() {
        self.dismiss(animated: true)
    }
}

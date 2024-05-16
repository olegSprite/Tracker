//
//  CreateTracerViewController + Extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 10.04.2024.
//

import Foundation
import UIKit

// MARK: - TableViewDelegate

extension CreateTrackerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = CategoriesInCreactingViewController()
            let categoryViewModel = CategoryViewModel()
            vc.initialize(viewModel: categoryViewModel)
            if let categoryCoreData = categoryCoreData {
                categoryViewModel.curentCategory?(categoryCoreData)
            }
            self.bind(viewModel: categoryViewModel)
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true)
        } else {
            let vc = TimetableViewController()
            vc.delegate = self
            vc.resultSetOfWeak = timetable
            let navController = UINavigationController(rootViewController: vc)
            self.present(navController, animated: true)
        }
    }
}

// MARK: - TableViewDataSource

extension CreateTrackerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isTracer ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.textColor = .black
        cell.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 235/255, alpha: 0.3)
        let text = indexPath.row == 0 ? "Категория" : "Расписание"
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        let subText = indexPath.row == 0 ? returnCategoryToTableView() : returnTimetableToTableView()
        cell.detailTextLabel?.text = subText
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 17)
        cell.detailTextLabel?.textColor = UIColor(red: 174/255, green: 175/255, blue: 180/255, alpha: 1)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - TextFieldDelegate

extension CreateTrackerViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField)  {
        if let text = textField.text {
            if text.count >= 1 && text.count <= 38 {
                textFieldСompleted = true
            } else {
                textFieldСompleted = false
            }
        }
        enabledSaveButtonOrNot()
    }
}

// MARK: - CollectionViewDelegate

extension CreateTrackerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EmogiAndColorCell else { return }
        if indexPath.section == 0 {
            if selectedEmogi != nil {
                selectedEmogiCell?.deselectEmogiCell()
            }
            cell.selectEmogiCell()
            selectedEmogi = cell.emogi.text
            selectedEmogiCell = cell
            enabledSaveButtonOrNot()
        } else {
            if selectedColor != nil {
                selectedColorCell?.deselectColorCell()
            }
            cell.selectColorCell()
            selectedColor = cell.colorView.backgroundColor
            selectedColorCell = cell
            enabledSaveButtonOrNot()
        }
    }
}

// MARK: - CollectionViewDataSource

extension CreateTrackerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? EmogiAndColorCell else { return UICollectionViewCell()}
        cell.setupCell()
        if indexPath.section == 0 {
            cell.setupEmogi(emoji[indexPath.row])
        } else {
            cell.setupColor(color: color[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let titile = indexPath.section == 0 ? "Emoji" : "Цвет"
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HeaderOfEmogiOrColorView else { return UICollectionReusableView()}
        view.titleLabel.text = titile
        return view
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension CreateTrackerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 6, height: 48)
    }
}

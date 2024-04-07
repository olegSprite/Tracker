//
//  Extention TracersViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 07.04.2024.
//

import Foundation
import UIKit

extension TracersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TracerViewCell else { return UICollectionViewCell() }
        cell.nameLable.text = tracers[indexPath.row].name
        return cell
    }
}



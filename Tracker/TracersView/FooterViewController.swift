//
//  FooterViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 23.05.2024.
//

import Foundation
import UIKit

final class FooterViewController: UICollectionReusableView {
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            configureView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            configureView()
        }
        
        private func configureView() {
            self.backgroundColor = UIColor.clear
        }
}

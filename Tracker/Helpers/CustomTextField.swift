//
//  TextField + Extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 15.04.2024.
//

import Foundation
import UIKit

final class CustomTextField: UITextField {

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -12, dy: 0)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

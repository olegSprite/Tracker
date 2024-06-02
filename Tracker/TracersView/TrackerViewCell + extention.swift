//
//  TrackerViewCell + extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 01.06.2024.
//

import Foundation
import UIKit

extension TracerViewCell: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        delegate?.returnContextMenu(cell: self)
    }
}

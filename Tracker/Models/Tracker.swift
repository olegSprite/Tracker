//
//  Tracker.swift
//  Tracker
//
//  Created by Олег Спиридонов on 06.04.2024.
//

import Foundation
import UIKit

struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emojy: String
    let timetable: [Timetable]
}

enum Timetable: Equatable, Codable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    case none
}

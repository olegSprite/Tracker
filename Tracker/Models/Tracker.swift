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

enum Timetable: String, Equatable, Codable {
    case monday = "Понедельник"
    case tuesday = "Вторник"
    case wednesday = "Среда"
    case thursday = "Четверг"
    case friday = "Пятница "
    case saturday = "Суббота"
    case sunday = "Воскресение"
    case none = "Без "
}

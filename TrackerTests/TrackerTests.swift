//
//  TrackerTests.swift
//  TrackerTests
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerTests: XCTestCase {

    func testViewControllerLight() {
            let vc = TrackersViewController()
        assertSnapshot(matching: vc, as: .image(traits: .init(userInterfaceStyle: .light)))
        }
    
    func testViewControllerDark() {
            let vc = TrackersViewController()
            assertSnapshot(matching: vc, as: .image(traits: .init(userInterfaceStyle: .dark)))
        }
}

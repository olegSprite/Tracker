//
//  TabBarViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import Foundation
import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
        }
    }
    
    private func createTabBar() {
        let trackersText = NSLocalizedString("trackers.tab", comment: "Трекеры")
        let statisticText = NSLocalizedString("statistic.tab", comment: "Статистика")
        viewControllers = [
            createViewController(
                viewController: TrackersViewController(),
                title: trackersText,
                image: UIImage(systemName: "record.circle.fill")),
            createViewController(
                viewController: StatisticViewController(),
                title: statisticText,
                image: UIImage(systemName: "hare.fill")),
        ]
    }
    
    private func createViewController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let result = UINavigationController(rootViewController: viewController)
        return result
    }
}

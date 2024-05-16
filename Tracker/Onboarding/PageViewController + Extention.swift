//
//  PageViewController + Extention.swift
//  Tracker
//
//  Created by Олег Спиридонов on 12.05.2024.
//

import Foundation
import UIKit

// MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let curentIndex = pages.firstIndex(of: viewController) else { return nil }
        if curentIndex == 0 {
            return pages.last
        } else {
            return pages[curentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let curentIndex = pages.firstIndex(of: viewController) else { return nil }
        if curentIndex < pages.count - 1 {
            return pages[curentIndex + 1]
        } else {
            return pages.first
        }
    }
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if let currentViewController = pageViewController.viewControllers?.first,
               let currentIndex = pages.firstIndex(of: currentViewController) {
                pageControl.currentPage = currentIndex
            }
        }
}

//
//  OnboardingViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 12.05.2024.
//

import Foundation
import UIKit

final class PageViewController: UIPageViewController {
    
    let pageControl = UIPageControl()
    private let closeButton = UIButton()
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        addCloseButton()
        setupPageControl()
    }
    
    private func setupPageViewController() {
        dataSource = self
        delegate = self
        guard let image1 = UIImage(named: "firstOnboardingScreen") else { return }
        guard let image2 = UIImage(named: "secondOnboardingScreen") else { return }
        let page1 = OnboardingScreenViewController(image: image1, numberOfScreen: 1)
        let page2 = OnboardingScreenViewController(image: image2, numberOfScreen: 2)
        pages.append(page1)
        pages.append(page2)
        setViewControllers([pages[0]], direction: .forward, animated: true)
    }
    
    private func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor(red: 26/255, green: 27/255, blue: 34/255, alpha: 0.3)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -24)
        ])
        
    }
    
    private func addCloseButton() {
        closeButton.backgroundColor = .black
        closeButton.setTitle("Вот это технологии!", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        closeButton.layer.masksToBounds = true
        closeButton.layer.cornerRadius = 16
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -84),
            closeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func closeButtonTap() {
        UserDefaults.standard.set("onboardingIsCompleted", forKey: "onboardingIsCompleted")
        let TabBarVC = TabBarViewController()
        TabBarVC.modalPresentationStyle = .fullScreen
        present(TabBarVC, animated: true)
    }
}

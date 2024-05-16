//
//  CattegoriesItCreactingViewController.swift
//  Tracker
//
//  Created by Олег Спиридонов on 10.04.2024.
//

import Foundation
import UIKit

final class CategoriesInCreactingViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var categories: [TrackerCategoryCoreData] = []
    var curentCategory: TrackerCategoryCoreData?
    var viewModel: CategoryViewModel?
    
    // MARK: - Private Properties
    
    private let plugImageView = UIImageView()
    private let plugLable = UILabel()
    private let createCategoryButton = UIButton()
    private let categoriesTableView = UITableView()
    private var heightCategoriesTableViewConstraint: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        addCreateCategoryButton()
    }
    
    // MARK: - MVVM
    
    func initialize(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        bind()
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.categoryes = { [weak self] category in
            if category.count == 0 {
                self?.setPlug(enebled: true)
            } else {
                self?.setPlug(enebled: false)
                self?.setCategoryes(categories: category)
            }
        }
        viewModel.curentCategory = { [weak self] curentCategory in
            self?.curentCategory = curentCategory
        }
    
        viewModel.fetchTrackerCategory()
    }
    
    private func setPlug(enebled: Bool) {
        if enebled {
            categoriesTableView.removeFromSuperview()
            addPlugImage()
            addPlugLable()
        } else {
            plugLable.removeFromSuperview()
            plugImageView.removeFromSuperview()
            addCategoriesTableView()
        }
    }
    
    private func setCategoryes(categories: [TrackerCategoryCoreData]) {
        self.categories = categories
        updateCategorys()
    }
    
    func updateCategorys() {
        heightCategoriesTableViewConstraint?.isActive = false
        heightCategoriesTableViewConstraint = categoriesTableView.heightAnchor.constraint(equalToConstant: CGFloat(75 * categories.count) - 1)
        heightCategoriesTableViewConstraint?.isActive = true
        categoriesTableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setupNavBar() {
        title = "Категория"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addPlugImage() {
        plugImageView.image = UIImage(named: "plugImage")
        plugImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugImageView)
        NSLayoutConstraint.activate([
            plugImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            plugImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            plugImageView.widthAnchor.constraint(equalToConstant: 80),
            plugImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func addPlugLable() {
        plugLable.text = "Привычки и события можно объединить по смыслу"
        plugLable.font = UIFont.systemFont(ofSize: 12)
        plugLable.numberOfLines = 2
        plugLable.textAlignment = .center
        plugLable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plugLable)
        NSLayoutConstraint.activate([
            plugLable.topAnchor.constraint(equalTo: plugImageView.bottomAnchor, constant: 8),
            plugLable.centerXAnchor.constraint(equalTo: plugImageView.centerXAnchor),
            plugLable.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func addCategoriesTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.layer.masksToBounds = true
        categoriesTableView.layer.cornerRadius = 16
        categoriesTableView.isScrollEnabled = false
        categoriesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoriesTableView)
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            categoriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func addCreateCategoryButton() {
        createCategoryButton.backgroundColor = .black
        createCategoryButton.tintColor = .white
        createCategoryButton.setTitle("Добавить категорию", for: .normal)
        createCategoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        createCategoryButton.addTarget(self, action: #selector(createCategoryButtonTap), for: .touchUpInside)
        createCategoryButton.layer.masksToBounds = true
        createCategoryButton.layer.cornerRadius = 16
        createCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createCategoryButton)
        NSLayoutConstraint.activate([
            createCategoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createCategoryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            createCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createCategoryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Action
    
    @objc private func createCategoryButtonTap() {
        let vc = CreateCategoryViewController()
        vc.categoriesInCreactingViewController = self
        let navController = UINavigationController(rootViewController: vc)
        self.present(navController, animated: true)
    }
}

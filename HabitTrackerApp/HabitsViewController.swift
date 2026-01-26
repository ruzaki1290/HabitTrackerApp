//
//  HabitsViewController.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 05.01.2026.
//

import UIKit

final class HabitsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Section: Int, CaseIterable {
        case progress
        case habits
    }
    
    // MARK: - UI
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    
    // MARK: - Data
    
    private var habits: [String] = [
        "Выпить стакан воды",
        "Сделать зарядку",
        "Сходить в душ",
        "Почистить зубы",
        "Позавтракать",
        "Поработать над проектом Нетологии",
        "Пообедать",
        "Закончить работу над проектом Нетологии",
        "Поужинать",
        "Принять душ",
        "Почистить зубы",
        "Почитать книгу",
        "Лечь спать"
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        setupTableView()
        
        
    } // viewDidLoad()
    
    // MARK: - Setup
    
    private func setupNavigation() {
        
        title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
        // Large titles
        navigationItem.largeTitleDisplayMode = .always
        // Добавляем кнопку “+”
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addHabitTapped)
        )
        
    }
    
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    } // setupUI()
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ProgressCell.self, forCellReuseIdentifier: ProgressCell.reuseID)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    // MARK: - Actions
    
    @objc private func addHabitTapped() {
        
        let vc = CreateHabitViewController()
        
        vc.onSave = { [weak self] title in
                guard let self else { return }

                self.habits.append(title)

                self.tableView.reloadData()
            }

        
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        
    }
    
    
} // class HabitsViewController

// MARK: - UITableViewDataSource
    
extension HabitsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = Section(rawValue: section) else { return 0 }

        switch section {
        case .progress:
            return 1
        case .habits:
            return habits.count
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        switch section {
            
        case .progress:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProgressCell.reuseID,
                for: indexPath
            ) as! ProgressCell
            
            cell.configure(title: "Всё получится!", progress: 0.5)
            return cell

        case .habits:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = habits[indexPath.row]
            cell.selectionStyle = .default
            return cell
            
        }
        
    } // tableView
    
} //UITableViewDataSource
    
// MARK: - UITableViewDelegate

extension HabitsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { return 44 }
        
        switch section {
        case .progress: return 80
        case .habits: return 44
        }
        
    }
        
}
    

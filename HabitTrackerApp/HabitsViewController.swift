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
    
    private let habits: [String] = [
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .singleLine
        
    }
    
    // MARK: - Actions
    
    @objc private func addHabitTapped() {
        
        let alert = UIAlertController(title: "Добавить привычку",
                                      message: "Скоро тут будет экран создания привычки 🙂",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        guard let section = Section(rawValue: indexPath.section) else { return cell }

        switch section {
        case .progress:
            cell.textLabel?.text = "Прогресс (пока заглушка)"
            cell.selectionStyle = .none

        case .habits:
            cell.textLabel?.text = habits[indexPath.row]
            cell.selectionStyle = .default
        }

        return cell
        
    }
    
} //UITableViewDataSource
    
// MARK: - UITableViewDelegate

extension HabitsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            guard let section = Section(rawValue: indexPath.section) else { return }
            guard section == .habits else { return }

            print("Tapped habit:", habits[indexPath.row])
        }
    
}

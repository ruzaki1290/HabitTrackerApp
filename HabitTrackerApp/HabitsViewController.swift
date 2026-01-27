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
    private var habits: [Habit] {
        HabitsStore.shared.habits
    }

        
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
            
                let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }

                let habit = Habit(name: trimmed, date: Date(), color: .systemBlue)
                HabitsStore.shared.habits.append(habit)

                self.tableView.reloadData()
                self.dismiss(animated: true)
            }

        
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        
    }
    
    
} // class HabitsViewController

// MARK: - UITableViewDataSource(DATA)
    
extension HabitsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    // MARK: - numberOfRowsInSection/Creates Rows of Cells
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = Section(rawValue: section) else { return 0 }

        switch section {
        case .progress:
            return 1
        case .habits:
            return habits.count
        }
        
    }

    // MARK: - cellForRowAt/Creates Cells
    
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
            
            cell.configure(title: "Всё получится!", progress: HabitsStore.shared.todayProgress)
            return cell

        case .habits:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let habit = habits[indexPath.row]
            cell.textLabel?.text = habit.name
            return cell
            
        }
        
    } // tableView
    
    // MARK: - commit editingStyle/ Save & Delete Cells
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {

        guard editingStyle == .delete else { return }
        guard indexPath.section == Section.habits.rawValue else { return }

        HabitsStore.shared.habits.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
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

} // UITableViewDelegate
    

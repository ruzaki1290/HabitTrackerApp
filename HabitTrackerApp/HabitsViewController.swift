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

        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(ProgressCell.self, forCellReuseIdentifier: ProgressCell.reuseID)
        tableView.register(HabitCell.self, forCellReuseIdentifier: HabitCell.reuseID)

        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130
        
    } // viewDidLoad()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }
    
    
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

    
    // MARK: - Actions
    
    @objc private func addHabitTapped() {
        
        let vc = CreateHabitViewController()
        
        vc.onSave = { [weak self] name, color, date in
                guard let self else { return }
                let habit = Habit(name: name, date: date, color: color)
                HabitsStore.shared.habits.append(habit)
                self.tableView.reloadData()
            }

        
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        
    }
    
} // class HabitsViewController


// MARK: - DataSource(ДАННЫЕ)
    
extension HabitsViewController: UITableViewDataSource {

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
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HabitCell.reuseID,
                for: indexPath
            ) as! HabitCell

            let habit = HabitsStore.shared.habits[indexPath.row]
            cell.configure(with: habit)

            cell.onCheckTapped = { [weak self] in
                guard let self else { return }

                HabitsStore.shared.toggleTrackToday(habit)

                // прогресс
                self.tableView.reloadRows(
                    at: [IndexPath(row: 0, section: Section.progress.rawValue)],
                    with: .none
                )

                // конкретная привычка (на случай если индекс сдвинется из-за reuse)
                if let row = HabitsStore.shared.habits.firstIndex(where: { $0 === habit }) {
                    self.tableView.reloadRows(
                        at: [IndexPath(row: row, section: Section.habits.rawValue)],
                        with: .none
                    )
                }
            }

            return cell


        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }

        switch section {
        case .progress:
            return 1
        case .habits:
            return HabitsStore.shared.habits.count
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    @objc private func toggleHabit(_ sender: UIButton) {
        let habit = HabitsStore.shared.habits[sender.tag]
        HabitsStore.shared.toggleTrackToday(habit)

        // обновляем прогресс (строка 0 в секции progress)
        tableView.reloadRows(at: [IndexPath(row: 0, section: Section.progress.rawValue)], with: .none)

        // обновляем конкретную привычку
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: Section.habits.rawValue)], with: .none)
    }

    
} // HabitsViewController
    
// MARK: - Delegate(ПОВЕДЕНИЕ ТАБЛИЦЫ)

extension HabitsViewController: UITableViewDelegate {

    // MARK: - Layout (Размеры ячеек)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { return UITableView.automaticDimension }
        switch section {
        case .progress:
            return 80
        case .habits:
            return UITableView.automaticDimension
        }
    }


    // MARK: - Navigation (переход в детали)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer { tableView.deselectRow(at: indexPath, animated: true) }

        guard indexPath.section == Section.habits.rawValue else { return }

        let habit = HabitsStore.shared.habits[indexPath.row]
        let vc = HabitDetailsViewController(habit: habit)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Actions (swipe actions /удаление)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard indexPath.section == Section.habits.rawValue else { return nil }

                let delete = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completion in

                    HabitsStore.shared.habits.remove(at: indexPath.row)

                    tableView.deleteRows(at: [indexPath], with: .automatic)

                    completion(true)
                }
        
        return UISwipeActionsConfiguration(actions: [delete])

    }

} // UITableViewDelegate

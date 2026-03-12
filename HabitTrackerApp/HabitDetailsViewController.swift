//
//  HabitDetailsViewController.swift
//  
//
//  Created by Rus Zakirov on 27.01.2026.
//

import UIKit

final class HabitDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    private let habit: Habit
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var dates: [Date] = []
    
    // MARK: - Int
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = habit.name
        view.backgroundColor = .systemBackground
        
        setupTable()
        setupNavBar()
        
        dates = makeDates()
        tableView.reloadData()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    // MARK: - Setup
    
    private func setupTable() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: view.topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    } // setupTable()
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .plain,
            target: self,
            action: #selector(editTapped)
        )
    }
    
    @objc private func editTapped() {
        let vc = CreateHabitViewController()
         vc.habitNameToEdit = habit.name

        vc.onSave = { [weak self] newName, newColor, newDate in
             guard let self else { return }
             self.habit.name = newName
             self.habit.color = newColor
             self.habit.date = newDate
             self.title = newName
             HabitsStore.shared.save()
             self.tableView.reloadData()
         }
        
            vc.onDelete = { [weak self] in
                guard let self else { return }

                // удаляем привычку из хранилища
                if let index = HabitsStore.shared.habits.firstIndex(where: { $0 === self.habit }) {
                    HabitsStore.shared.habits.remove(at: index)
                }

                // после удаления уходим назад на список
                self.navigationController?.popToRootViewController(animated: true)
            }

         navigationController?.pushViewController(vc, animated: true)
    }
    
    private func makeDates() -> [Date] {
        
        let calendar = Calendar.current
        var result: [Date] = []
        
        for daysOffset in 1...365 {
            if let date = calendar.date(byAdding: .day,
                                        value: -daysOffset,
                                        to: Date()) {
                result.append(date)
            }
        }
        return result
        
    }
    
    private func titleForDate(_ date: Date) -> String {
            let calendar = Calendar.current

            if calendar.isDateInYesterday(date) { return "Вчера" }

            if let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: Date()),
               calendar.isDate(date, inSameDayAs: twoDaysAgo) {
                return "Позавчера"
            }

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.dateFormat = "d MMMM yyyy"
            return formatter.string(from: date)
        }

    
} // HabitDetailsViewController

extension HabitDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
        return dates.count
        
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            let date = dates[indexPath.row]
            cell.textLabel?.text = titleForDate(date)
            
            let isDone = HabitsStore.shared.habit(habit, isTrackedIn: date)
            cell.accessoryType = isDone ? .checkmark : .none
            return cell
            
        }
    
    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
    
}

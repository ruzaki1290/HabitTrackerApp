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
    }
    
    // MARK: - Setup
    
    private func setupTable() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .plain,
            target: self,
            action: #selector(editTapped)
        )
    }
    
    @objc private func editTapped() {
        print("Edit tapped")
    }
    
} // HabitDetailsViewController

extension HabitDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            return 10 // временно, потом заменим на реальные даты
        }

        func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Day \(indexPath.row)"
            return cell
        }
    
}

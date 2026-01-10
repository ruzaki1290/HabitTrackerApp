//
//  HabitsViewController.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 05.01.2026.
//

import UIKit

class HabitsViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
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
    
    @objc private func addHabitTapped() {
            let alert = UIAlertController(title: "Добавить привычку",
                                          message: "Скоро тут будет экран создания привычки 🙂",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .default))
            present(alert, animated: true)
        }
    

} // class HabitsViewController

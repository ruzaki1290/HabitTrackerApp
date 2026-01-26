//
//  CreateHabitViewController.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 26.01.2026.
//

import UIKit

final class CreateHabitViewController: UIViewController {
    
    // callback назад в список
    var onSave: ((String) -> Void)?
    
    private let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Новая привычка"
        
        setupUI()
        setupNavBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
 
    // MARK: - UI
    
    private func setupUI() {
        
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        textField.placeholder = "Название привычки"
        textField.borderStyle = .roundedRect
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
    // MARK: - Navigation
    
    private func setupNavBar() {
        
           navigationItem.rightBarButtonItem = UIBarButtonItem(
               title: "Сохранить",
               style: .done,
               target: self,
               action: #selector(saveTapped)
           )
        
       }
    
    @objc private func saveTapped() {
        
            let text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            guard !text.isEmpty else { return }
            onSave?(text)
            dismiss(animated: true)
        
        }
    
    
} // CreateHabitViewController


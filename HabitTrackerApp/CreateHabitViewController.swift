//
//  CreateHabitViewController.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 26.01.2026.
//

import UIKit

final class CreateHabitViewController: UIViewController {

// MARK: - Public callbacks/input
    
    // callback назад в список
    var onSave: ((String, UIColor, Date) -> Void)?
    
    // callback на удаление
    var onDelete: (() -> Void)?
    
    // Режим редактирования
    var habitNameToEdit: String?
// MARK: - UI
    
    private let textField = UITextField()
    
    private let colorTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Цвет"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let colorPicker: UIColorWell = {
        let picker = UIColorWell()
        picker.selectedColor = .systemBlue
        return picker
    }()
    
    private let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let timeValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .right
        label.textColor = .systemGray
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ru_RU")
        return picker
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()

// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupNavBar()
        configureForMode()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }

// MARK: - Configuration
    
    private func configureForMode() {
        
        if let name = habitNameToEdit {
            title = "Править"
            textField.text = name
        } else {
            title = "Новая привычка"
        }
        
    }
 
// MARK: - Setup UI
    
    private func setupUI() {
        
        textField.isUserInteractionEnabled = true
        textField.isEnabled = true
        textField.placeholder = "Название привычки"
        textField.borderStyle = .roundedRect
        
        view.addSubview(textField)
        view.addSubview(colorTitleLabel)
        view.addSubview(colorPicker)
        view.addSubview(timeTitleLabel)
        view.addSubview(timeValueLabel)
        view.addSubview(datePicker)
        textField.translatesAutoresizingMaskIntoConstraints = false
        colorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        timeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        timeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        dateChanged()

        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 44),

            colorTitleLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 24),
            colorTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            colorPicker.centerYAnchor.constraint(equalTo: colorTitleLabel.centerYAnchor),
            colorPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            colorPicker.widthAnchor.constraint(equalToConstant: 30),
            colorPicker.heightAnchor.constraint(equalToConstant: 30),

            timeTitleLabel.topAnchor.constraint(equalTo: colorTitleLabel.bottomAnchor, constant: 24),
            timeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            timeValueLabel.centerYAnchor.constraint(equalTo: timeTitleLabel.centerYAnchor),
            timeValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            datePicker.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 44)
            
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
        
       }

// MARK: - Actions
    
    @objc private func saveTapped() {
        
            let text = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        
            guard !text.isEmpty else {
                let alert = UIAlertController(
                    title: "Ошибка",
                    message: "Введите название привычки",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "ОК", style: .default))
                present(alert, animated: true)
                return
            }
        
        let selectedColor = colorPicker.selectedColor ?? .systemBlue
        let selectedDate = datePicker.date
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        onSave?(text, selectedColor, selectedDate)
        
        if presentingViewController != nil {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    } // saveTapped()
    
    @objc private func deleteTapped() {
        showDeleteAlert()
    }

    private func showDeleteAlert() {
        
        let habitName = (textField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let nameForMessage = habitName.isEmpty ? "эту привычку" : "«\(habitName)»"

        let alert = UIAlertController(
            title: "Удалить привычку",
            message: "Вы хотите удалить привычку \(nameForMessage)?",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.onDelete?()          // <-- вот тут должно реально удалять в родителе/хранилище
            self.dismiss(animated: true)
        })

        present(alert, animated: true)
        
    }

    
    @objc private func backTapped() {
        
        if let nav = navigationController, nav.viewControllers.first == self {
            nav.dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc private func dateChanged() {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        timeValueLabel.text = formatter.string(from: datePicker.date)
        
    }


} // CreateHabitViewController


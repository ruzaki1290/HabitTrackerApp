//
//  HabitCell.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 21.01.2026.
//

import UIKit

final class HabitCell: UITableViewCell {
    
    // MARK: - UI
    
    private let cardView = UIView()
    private let titleLabel = UILabel()
    private let timeLabel = UILabel()
    private let counterLabel = UILabel()
    private let checkButton = UIButton(type: .system)
    var onCheckTapped: (() -> Void)?
    static let reuseID = "HabitCell"

    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
            setupConstraints()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func configure(with habit: Habit) {
        titleLabel.text = habit.name
        timeLabel.text = habit.dateString
        counterLabel.text = "Счётчик: \(habit.trackDates.count)"

        // кружок/галочка
        if habit.isAlreadyTakenToday {
            checkButton.backgroundColor = habit.color
            checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            checkButton.tintColor = .white
            checkButton.layer.borderWidth = 0
        } else {
            checkButton.backgroundColor = .clear
            checkButton.setImage(nil, for: .normal)
            checkButton.tintColor = .clear
            checkButton.layer.borderWidth = 2
            checkButton.layer.borderColor = habit.color.cgColor
        }
    }

    
    // MARK: - Setup
    
    private func setupUI() {
        
           selectionStyle = .none
           backgroundColor = .clear
           contentView.backgroundColor = .clear

           cardView.translatesAutoresizingMaskIntoConstraints = false
           cardView.backgroundColor = .secondarySystemBackground
           cardView.layer.cornerRadius = 12
           cardView.layer.masksToBounds = true

           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
           titleLabel.numberOfLines = 2

           timeLabel.translatesAutoresizingMaskIntoConstraints = false
           timeLabel.font = .systemFont(ofSize: 13, weight: .regular)
           timeLabel.textColor = .secondaryLabel
           timeLabel.numberOfLines = 1

           counterLabel.translatesAutoresizingMaskIntoConstraints = false
           counterLabel.font = .systemFont(ofSize: 13, weight: .regular)
           counterLabel.textColor = .secondaryLabel
           counterLabel.numberOfLines = 1
        
           checkButton.layer.cornerRadius = 20
           checkButton.layer.borderWidth = 2
           checkButton.translatesAutoresizingMaskIntoConstraints = false

           contentView.addSubview(cardView)
           cardView.addSubview(titleLabel)
           cardView.addSubview(timeLabel)
           cardView.addSubview(counterLabel)
           cardView.addSubview(checkButton)
        
           checkButton.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)

       }
    
    private func setupConstraints() {
        
            NSLayoutConstraint.activate([
              
                cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

                titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: checkButton.leadingAnchor, constant: -12),

                timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
                timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                timeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

                counterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 14),
                counterLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                counterLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                counterLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
                
                checkButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
                checkButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                checkButton.widthAnchor.constraint(equalToConstant: 40),
                checkButton.heightAnchor.constraint(equalToConstant: 40)
                
            ])
        
        }
    
    @objc private func checkTapped() {
        onCheckTapped?()
    }
    
} // HabitCell

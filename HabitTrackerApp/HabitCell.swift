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
    private let statusImageView = UIImageView()
    
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
    
    func configure(title: String,
                       time: String,
                       counter: Int,
                       color: UIColor,
                       isDone: Bool) {

            titleLabel.text = title
            titleLabel.textColor = color

            timeLabel.text = "Каждый день в \(time)"
            counterLabel.text = "Счётчик: \(counter)"

            if isDone {
                statusImageView.image = UIImage(systemName: "checkmark.circle.fill")
                statusImageView.tintColor = color
            } else {
                statusImageView.image = UIImage(systemName: "circle")
                statusImageView.tintColor = color
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

           statusImageView.translatesAutoresizingMaskIntoConstraints = false
           statusImageView.contentMode = .scaleAspectFit

           contentView.addSubview(cardView)
           cardView.addSubview(titleLabel)
           cardView.addSubview(timeLabel)
           cardView.addSubview(counterLabel)
           cardView.addSubview(statusImageView)
        
       }
    
    private func setupConstraints() {
        
            NSLayoutConstraint.activate([
              
                cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

                statusImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
                statusImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
                statusImageView.widthAnchor.constraint(equalToConstant: 36),
                statusImageView.heightAnchor.constraint(equalToConstant: 36),

                titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: statusImageView.leadingAnchor, constant: -12),

                timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
                timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                timeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

                counterLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 14),
                counterLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                counterLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
                counterLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16)
                
            ])
        
        }
    
} // HabitCell

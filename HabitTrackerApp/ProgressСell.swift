//
//  ProgressСell.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 21.01.2026.
//

import UIKit

final class ProgressCell: UITableViewCell {
    
    static let reuseID = "ProgressCell"
    
// MARK: - UI
    
    private let cardView = UIView()
      private let titleLabel = UILabel()
      private let percentLabel = UILabel()
      private let progressView = UIProgressView(progressViewStyle: .default)

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
    
    func configure(title: String, progress: Float) {
        
            titleLabel.text = title
            percentLabel.text = "\(Int(progress * 100))%"
            progressView.progress = progress
        
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
           titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
           titleLabel.textColor = .secondaryLabel

           percentLabel.translatesAutoresizingMaskIntoConstraints = false
           percentLabel.font = .systemFont(ofSize: 14, weight: .semibold)
           percentLabel.textColor = .secondaryLabel
           percentLabel.textAlignment = .right

           progressView.translatesAutoresizingMaskIntoConstraints = false
           progressView.clipsToBounds = true
           progressView.layer.cornerRadius = 4
           progressView.trackTintColor = .systemGray5

           contentView.addSubview(cardView)
           cardView.addSubview(titleLabel)
           cardView.addSubview(percentLabel)
           cardView.addSubview(progressView)
        
       }
    
    private func setupConstraints() {
        
            NSLayoutConstraint.activate([
                
                cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

                titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
                titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),

                percentLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
                percentLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
                percentLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),

                progressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                progressView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
                progressView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
                progressView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
                progressView.heightAnchor.constraint(equalToConstant: 6)
                
            ])
        
        }
    
} // ProgressCell

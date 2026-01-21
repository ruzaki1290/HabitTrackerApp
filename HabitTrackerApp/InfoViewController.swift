//
//  InfoViewController.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 05.01.2026.
//

import UIKit

final class InfoViewController: UIViewController {
    
// MARK: UI
    
    private let scrollView = UIScrollView()
        private let contentView = UIView()

        private let titleLabel: UILabel = {
            
            let label = UILabel()
            label.text = "Привычка за 21 день"
            label.font = .systemFont(ofSize: 34, weight: .bold)
            label.numberOfLines = 0
            return label
            
        }()

        private let bodyLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 17, weight: .regular)
            label.numberOfLines = 0
            label.textColor = .label
            label.text =
            
    """
    Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

    1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

    2. Выдержать 2 дня в прежнем состоянии самоконтроля.

    3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.

    4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

    5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого.
    
    """
            
            return label
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Информация"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupLayout()
        
        
        
    }
    
// MARK: Private Methods
    
    private func setupLayout() {
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)

            contentView.addSubview(titleLabel)
            contentView.addSubview(bodyLabel)

            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            bodyLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

                contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

                bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
                bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        }

} // class InfoViewController

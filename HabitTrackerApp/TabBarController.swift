//
//  File.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 09.01.2026.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }

    private func setupViewControllers() {
        let habitsVC = HabitsViewController()
        let habitsNav = UINavigationController(rootViewController: habitsVC)
        habitsNav.navigationBar.prefersLargeTitles = true
        habitsNav.tabBarItem = UITabBarItem(title: "Привычки",
                                            image: UIImage(systemName: "square.grid.2x2"),
                                            selectedImage: UIImage(systemName: "square.grid.2x2.fill"))

        let infoVC = InfoViewController()
        let infoNav = UINavigationController(rootViewController: infoVC)
        infoNav.navigationBar.prefersLargeTitles = true
        infoNav.tabBarItem = UITabBarItem(title: "Информация",
                                          image: UIImage(systemName: "info.circle"),
                                          selectedImage: UIImage(systemName: "info.circle.fill"))

        viewControllers = [habitsNav, infoNav]
    }
}

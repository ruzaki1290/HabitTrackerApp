//
//  HabitsStorage.swift
//  HabitTrackerApp
//
//  Created by Rus Zakirov on 26.01.2026.
//

import Foundation

final class HabitsStorage {
    
    static let shared = HabitsStorage()
        private init() {}

        private let key = "habits_titles_v1"
        private let defaults = UserDefaults.standard

        func load() -> [String] {
            defaults.stringArray(forKey: key) ?? []
        }

        func save(_ habits: [String]) {
            defaults.set(habits, forKey: key)
        }
    
} // HabitsStorage

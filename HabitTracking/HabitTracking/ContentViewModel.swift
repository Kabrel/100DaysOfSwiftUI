//
//  ContentViewModel.swift
//  HabitTracking
//
//  Created by Константин Шутов on 19.08.2023.
//

import SwiftUI

struct Habit: Codable {
    var name: String
    var text: String
    var count: Int
}

class HabitsModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    init() {
        initHabits()
    }
    
    func initHabits() {
        if let data = UserDefaults.standard.data(forKey: "habits") {
            if let decodeHabits = try? JSONDecoder().decode([Habit].self, from: data) {
                habits = decodeHabits
                return
            }
        }
        
        habits = []
    }
    
    func saveHabits() {
        if let encodedHabits = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encodedHabits, forKey: "habits")
        }
    }
    
    func addCount(for habit: Habit) {
        if let pos = habits.firstIndex(where: { $0.name == habit.name }) {
            habits[pos].count += 1
            saveHabits()
        }
    }
}

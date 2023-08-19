//
//  ContentView.swift
//  HabitTracking
//
//  Created by Константин Шутов on 19.08.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = HabitsModel()
    
    @State private var isShowingNewHabitSheet = false
    @State private var newHabitName = "HabitName"
    @State private var newHabitText = "Description"
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.habits, id: \.name) { habit in
                    NavigationLink(destination: HabitDetailView(habit: habit),
                                   label: {
                        Text(habit.name)
                    })
                    
                }
            }
            .navigationTitle("Habits Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isShowingNewHabitSheet = true
                    },
                           label: {
                        Image(systemName: "plus")
                    })
                }
            }
        }
        .sheet(isPresented: $isShowingNewHabitSheet) {
            VStack {
                Spacer()
                
                TextField("Habit Name:" , text: self.$newHabitName)
                TextField("Habit Description", text: self.$newHabitText)
                
                Button(action: {
                    let newHabit = Habit(name: self.newHabitName,
                                         text: self.newHabitText,
                                         count: 0)
                    
                    self.viewModel.habits.append(newHabit)
                    self.viewModel.saveHabits()
                    self.isShowingNewHabitSheet = false
                },
                       label: {
                    Text("Save")
                })
                
                Spacer()
            }
            .padding(40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

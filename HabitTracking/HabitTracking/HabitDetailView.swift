//
//  HabitDetailView.swift
//  HabitTracking
//
//  Created by Константин Шутов on 19.08.2023.
//

import SwiftUI

struct HabitDetailView: View {
    @ObservedObject var habitView = HabitsModel()
    
    var habit: Habit
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            Text(habit.name)
                .font(.largeTitle)
            
            HStack(alignment: .top) {
                Text(habit.text)
                    .font(.title)
                
                Spacer()
            }
            .frame(width: 300, height: 400)
            
            HStack {
                Text("Count \(habit.count)")
                Button(action: {
                    habitView.addCount(for: self.habit)
                },
                       label: {
                    Text("Add")
                })
            }
            
            Spacer()
            
        }
        .padding(15)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habit: Habit(name: "2", text: "text", count: 1))
    }
}

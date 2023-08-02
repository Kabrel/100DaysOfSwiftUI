//
//  ContentView.swift
//  Edutainment App
//
//  Created by Константин Шутов on 31.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var multipleOF = 2
    @State private var questionCount = 5
    
    let questions = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                Text("Multiplication table")
                    .font(.largeTitle)
                
                Spacer()
                
                HStack {
                    Text("Multiple of:")
                    
                    Picker("Multiple of", selection: $multipleOF) {
                        ForEach(2..<13) {
                            Text("\($0)")
                        }
                    }
                }
                .font(.title)
                
                HStack {
                    Text("Number of questions:")
                    
                    Picker("Number of questions", selection: $questionCount) {
                        ForEach(questions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                .font(.title)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        GameView(multiple: $multipleOF, endTurn: $questionCount)
                    } label: {
                        Image(systemName: "play.fill")
                            .font(.system(size: 100))
                            .foregroundColor(.yellow)
                    }
                    .padding(40)
                    
                    Spacer()
                }
            }
            .padding(10)
            .background(.cyan)
            .foregroundColor(.white)
            .accentColor(.white)
        }
//        .accentColor(.white)
//        .toolbarColorScheme(.dark, for: .navigationBar)
//        .toolbarBackground(Color(.cyan), for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

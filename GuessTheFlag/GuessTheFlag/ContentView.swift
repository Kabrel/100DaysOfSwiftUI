//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Константин Шутов on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreNumber = 0
    @State private var gameEnd = false
    
    @State private var scoreTitle = ""
    @State private var endTitle = ""
    
    @State private var userPressedBtn = 0
    
    @State private var animationAmount = 0.0
    @State private var animationOpacity = 1.0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            userPressedBtn = number
                            flagTapped(number)
                            withAnimation(
                                .interpolatingSpring(stiffness: 10, damping: 5)) {
                                animationAmount += 360
                                animationOpacity = 0.25
                            }
                        } label: {
                            Image("\(countries[number])")
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        .rotation3DEffect(
                            .degrees(userPressedBtn == number ? animationAmount : 0),
                            axis: (x: 0, y: 1, z: 0)
                        )
                        .rotation3DEffect(
                            .degrees(userPressedBtn != number ? -animationAmount : 0 ),
                            axis: (x: 1, y: 0, z: 0)
                        )
                        .opacity(userPressedBtn != number ? animationOpacity : 1)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreNumber)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(scoreNumber)")
        }
        .alert(endTitle, isPresented: $gameEnd) {
            Button("Restart Game", action: restartGame)
        } message: {
            Text("You won this game!")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreNumber += 1
            if scoreNumber >= 8 {
                gameEnd = true
                return
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            if scoreNumber > 1 {
                scoreNumber -= 1
            } else {
                scoreNumber = 0
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animationAmount = 0
        animationOpacity = 1
    }
    
    func restartGame() {
        scoreNumber = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

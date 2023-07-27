//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Константин Шутов on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var gameEnd = false
    @State private var gameTurn = 0
    @State private var userScore = 0
    @State private var variants = ["Rock", "Paper", "Scissors"]
    @State private var winCondition = Int.random(in: 0...1)
    @State private var pcChoose = Int.random(in: 0...2)
    
    let buttonImage = ["hand.thumbsup.fill", "hand.wave.fill", "scissors"]
    let condition = ["Win", "Lose"]
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                
                VStack(spacing: 15) {
                    Text("App choice is \(variants[pcChoose])")
                        .font(.largeTitle.weight(.heavy))
                    Text("You should \(condition[winCondition])")
                        .font(.largeTitle.weight(.bold))
                }
                
                Spacer()
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            iconTapped(number)
                        } label: {
                            Label(variants[number], systemImage: buttonImage[number])
                        }
                        .labelStyle(.iconOnly)
                        .font(.system(size: 70))
                        .foregroundColor(.black)
                        .clipped()
                    }
                }
                .padding(20)
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert("", isPresented: $gameEnd) {
            Button("Restart Game", action: restartGame)
        } message: {
            Text("Game End! \r\n Your score is \(userScore)")
        }
    }
    
    func iconTapped(_ number: Int) {
        if winCondition == 0 {
            switch (pcChoose, number) {
            case (0, 1):
                userScore += 1
            case (1, 2):
                userScore += 1
            case (2, 0):
                userScore += 1
            default:
                userScore -= 1
            }
        } else {
            switch (pcChoose, number) {
            case (0, 1):
                userScore -= 1
            case (1, 2):
                userScore -= 1
            case (2, 0):
                userScore -= 1
            default:
                userScore += 1
            }
        }
        nextTurn()
    }
    
    func nextTurn() {
        if gameTurn >= 8 {
            gameEnd = true
        } else {
            gameTurn += 1
            winCondition = Int.random(in: 0...1)
            pcChoose = Int.random(in: 0...2)
        }
    }
    
    func restartGame() {
        gameTurn = -1
        userScore = 0
        nextTurn()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

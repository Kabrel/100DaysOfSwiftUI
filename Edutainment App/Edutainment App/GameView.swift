//
//  GameView.swift
//  Edutainment App
//
//  Created by Константин Шутов on 01.08.2023.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var multiple: Int
    @Binding var endTurn: Int
    
    @State private var userScore = 0
    @State private var currentTurn = 0
    @State private var currentQuest = ""
    @State private var answerVariants = [0, 1 , 2 , 3]
    @State private var rightAnswer = 0
    @State private var imageName = "checkmark"
    @State private var imageOppacity = 0.0
    @State private var imageColor = Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.3, alpha: 1))
    
    @State private var gameEnd = false
    
    var realMultiple: Int {
        return multiple + 2
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                
                Image(systemName: imageName)
                    .font(.system(size: 60))
                    .frame(width: 200, height: 100)
                    .background(imageColor)
                    .clipShape(Circle())
                    .opacity(imageOppacity)
                
                
                Text("\(currentQuest)")
                    .font(.largeTitle)
                    .frame(width: 260, height: 120)
                    .background(.yellow)
                    .clipShape(Capsule())
                    .padding(50)
                
                HStack {
                    Spacer()
                    
                    ForEach(answerVariants, id: \.self) {num in
                        Button("\(num)") {
                            checkAnswer(num: num)
                        }
                    }
                    .padding(10)
                    .frame(width: 60, height: 60)
                    .background(.orange)
                    .font(.headline)
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                }
                
                Spacer()
                Spacer()
            }
            .background(.cyan)
        }
        .navigationTitle("Turn \(currentTurn)/\(endTurn)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear(perform: newGame)
        .alert("Game End", isPresented: $gameEnd) {
            Button("Restart game", action: newGame)
            Button("Cancel", role: .cancel) {
                dismiss()
            }
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    
    func newGame() {
        currentTurn = 0
        userScore = 0
        newTurn()
    }
    
    func nextTurn() {
        if currentTurn == endTurn {
            gameEnd = true
        } else {
            currentTurn += 1
        }
    }
    
    func showImage(answer: Bool) {
        print("Change image")
        if answer == true {
            imageName = "checkmark"
            imageColor = Color(#colorLiteral(red: 0.8, green: 0.8, blue: 0.3, alpha: 1))
        } else {
            imageName = "xmark"
            imageColor = Color(.red)
        }
        withAnimation(.interpolatingSpring(stiffness: 10, damping: 5)) {
            imageOppacity = 1.0
        }
    }
    
    func newTurn() {
        withAnimation(.easeOut.delay(1)) {
            imageOppacity = 0.0
        }
        nextTurn()
        let randomInt = (1..<13).randomElement() ?? 1
        currentQuest = "\(realMultiple) x \(randomInt) = ?"
        rightAnswer = realMultiple * randomInt
        answerVariants = [rightAnswer]
        while answerVariants.count != 4 {
            let randomAnswer = (rightAnswer - 10..<rightAnswer + 10).randomElement()!
            if !answerVariants.contains(randomAnswer) {
                answerVariants.append(randomAnswer)
            }
        }
        answerVariants.shuffle()
    }
    
    func checkAnswer(num: Int) {
        let currentAnswer = num
        let result = currentAnswer == rightAnswer
        if  result {
            userScore += 1
        }
        showImage(answer: result)
        newTurn()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(multiple: .constant(5), endTurn: .constant(5))
    }
}

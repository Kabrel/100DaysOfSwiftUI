//
//  ContentView.swift
//  WordScramble
//
//  Created by Константин Шутов on 27.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var userScore = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            NavigationView {
                List {
                    Section {
                        Text(rootWord)
                    } header: {
                        Text("Scramble this word")
                            .font(.headline)
                    }
                    
                    Section {
                        TextField("Enter your word", text: $newWord)
                            .autocapitalization(.none)
                    } header: {
                        Text("Your score is \(userScore)")
                            .font(.headline)
                    }
                    
                    Section {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Image(systemName: "\(word.count).circle.fill")
                                Text(word)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup {
                    Button("Restart game") {
                        startGame()
                    }
                }
            }
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard checkWord(word: answer) else {
            newWord = ""
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        userScore += answer.utf16.count
        newWord = ""
    }
    
    func checkWord(word: String) -> Bool {
        guard isNotRootWord(word: word) else {
            wordError(title: "Word is \(rootWord)", message: "No cheating allowed!")
            return false
        }
        
        guard isLong(word: word) else {
            wordError(title: "Word is to short", message: "You can't use words less than 3 letters!")
            return false
        }
        
        guard isOriginal(word: word) else {
            wordError(title: "Word used already", message: "Be more original!")
            return false
        }
        
        guard isPossible(word: word) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return false
        }
        
        guard isReal(word: word) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return false
        }
        
        return true
    }
    
    func startGame() {
        usedWords = [String]()
        userScore = 0
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                print("Is running")
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isNotRootWord(word: String) -> Bool {
        if word != rootWord {
            return true
        } else {
            return false
        }
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isLong(word: String) -> Bool {
        if word.utf16.count > 2 {
            return true
        } else {
            return false
        }
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

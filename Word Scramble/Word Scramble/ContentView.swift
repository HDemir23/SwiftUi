//
//  ContentView.swift
//  Word Scramble
//
//  Created by Hakan Demir on 22.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedword = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorMessage = ""
    @State private var errorTitle = ""
    @State private var showingError = false
    
    var body: some View {
        
        NavigationView{
            
            List{
                Button("newWord"){
                    startGame()
                }
                .backgroundStyle(Color.accentColor.opacity(0.3))
                Section{
                    TextField("please enter your text" , text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section{
                    ForEach(usedword, id: \.self) { word in
                        
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit {
                addNewWord()
            }
            .onAppear(perform: startGame)
            
            
            .alert(errorTitle, isPresented: $showingError){
                Button("OK" , role: .cancel) {}
            } message:{
                Text(errorMessage)
            }
            

        }
        
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            showError(title: ("word used"), message: ("be more original"))
            return
        }
        
        guard isPossible(word: answer) else {
            showError(title: ("word not correct"), message: ("check your spelling "))
            return
        }
        
        
        guard isReel(word: answer) else {
            showError(title: ("word not exist"), message: ("u cant make them up"))
            return
        }
        
        withAnimation {
            usedword.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    
    
    func startGame(){
        if let startWordsUrl = Bundle.main.url(forResource: "Start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("COuld not found Start.txt")
    }
    
    
    func isOriginal(word: String) -> Bool {
        !usedword.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else{
                return false
            }
        }
        return true
    }
    
    
    func isReel(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspled = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        
        return misspled.location == NSNotFound
    }
    
    func showError (title: String, message: String){
        errorMessage = message
        errorTitle = title
        showingError = true
    }
    
    
}

#Preview {
    ContentView()
}

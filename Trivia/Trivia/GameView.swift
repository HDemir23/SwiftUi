//
//  GameView.swift
//  Trivia
//
//  Created by Hakan Demir on 30.04.2025.
//

import SwiftUI



struct GameView: View {
    
    
        let difficultyLevel: String
        let amount: Int
    

    
    @State private var triviaQ: [TriviaQuestions] = []
    @State private var currentQ: TriviaQuestions?
    @State private var answers:[String] = []
    @State private var selectedAnswer: String? = nil
    @State private var correctAnswer: Bool? = nil
    @State private var currentIndex: Int = 0
    @State private var showAlert = false
    @State private var showCompletionAlert = false
    @State private var endWord = ""

    
    @State private var score: Int = 0
    

    var body: some View {
        NavigationView{
            VStack{
                
                
                if triviaQ.isEmpty{
                    Text("Loading...") // api call bekliyoruz
                } else {
                    
                    
                    // Burada soruyu sorduk
                    VStack{
                        if let question = currentQ{
                            Text(question.question)
                                .padding()
                                .font(.headline.bold())
                        }
                        
                    }
                    
                    
                    
                    
                    // Burada cevaplari yazdirdik
                    ForEach(answers , id: \.self) { answer in
                        
                        Button(action: {
                            selectedAnswer = answer
                            isTrue()
                            
                        })
                        {
                            Text(answer)
                        }
                        
                        
                    }
                    .padding(50)
                    .alert(isPresented: Binding(
                        get: { showAlert || showCompletionAlert },
                        set: { _ in
                            showAlert = false
                            showCompletionAlert = false
                        })
                    ) {
                        if showCompletionAlert {
                            return Alert(
                                title: Text("Game Complete"),
                                message: Text("You got \(score) out of \(amount) questions correct!"),
                                dismissButton: .default(Text("Restart")) {
                                    
                                }
                            )
                        } else {
                            return Alert(
                                title: Text("Wrong Answer"),
                                message: Text("That wasn't the correct answer. Give it another shot!"),
                                dismissButton: .default(Text("Try Again")) {
                                    resetGame()
                                }
                            )
                        }
                    }
                }

                    
                }
            .navigationTitle("Trivia")
            .navigationBarTitleDisplayMode(.inline)
        
            .task {
                triviaQ = await fetchData(for: difficultyLevel, amount: amount)
                
                guard !triviaQ.isEmpty else {
                    print("❌ triviaQ is empty")
                    return
                }
                
                
                currentIndex = 0
                currentQ = triviaQ[currentIndex]
                
                if let question = currentQ {
                    answers = (question.incorrect_answers + [question.correct_answer]).shuffled()
                }
            }
  
            }
            
            
            
            
            
        }
        
        func isTrue(){
            guard let current = currentQ else {
                
                print("❌ currentQ is nil")
                return
            }
            
            
            if selectedAnswer == current.correct_answer {
                correctAnswer = true
                
                
                score += calculateScore(for: difficultyLevel)
                
                let nextQ = currentIndex + 1
                
                if currentIndex + 1 >= triviaQ.count {
                    showCompletionAlert = true
                    currentQ = nil
                    return
                }
                
                
                guard nextQ < triviaQ.count else {
                    print("🏁 Finished all questions")
                    showCompletionAlert = true
                    currentQ = nil
                    return
                }
                
                currentIndex = nextQ
                currentQ = triviaQ[currentIndex]
                
                if let question = currentQ {
                    answers = (question.incorrect_answers + [question.correct_answer]).shuffled()
                }
                
                selectedAnswer = nil
                correctAnswer = nil
            } else {
                correctAnswer = false
                showAlert = true
                
            }
        }
        
    
        
        func resetGame() {
            currentIndex = 0
            if !triviaQ.isEmpty {
                currentQ = triviaQ[0]
                answers = (triviaQ[0].incorrect_answers + [triviaQ[0].correct_answer]).shuffled()
            }
            selectedAnswer = nil
            correctAnswer = nil
            score = 0
        }
        
        
        func calculateScore(for difficultyLevel: String) -> Int{
            switch difficultyLevel.lowercased() {
            case "easy":
                return 5
            case "medium":
                return 10
            case "hard":
                return 20
            default:
                return 10
            }
        }
    
    

        
    
}

#Preview {
    GameView(difficultyLevel: "any", amount: 5 )
}

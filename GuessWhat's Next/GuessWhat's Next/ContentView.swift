//
//  ContentView.swift
//  GuessWhat's Next
//
//  Created by Hakan Demir on 17.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScore = false
    @State private var score = 0 {
        didSet {
            if score < 0 {
                score = 0
            }
        }
    }
    @State private var roundNumber = 1
    
    
    
    @State private var countries = ["Estonia", "France" , "Ireland" , "Italy" ,"Monaco","Poland","Spain","UK"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26 ), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack (spacing: 15){
                    VStack{
                        
                        Text(countries[correctAnswer])
                            
                            .font(.title.weight(.semibold))

                    }
                    
                    ForEach(0..<3) {
                        number in
                        Button{
                            flagTapped(number)
                        }  label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical ,20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                // MARK: - Score and Round
                
                Text("Round =  \(roundNumber)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .padding(.top ,35)
                Text("Score = \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            
        }
        
        
        .alert("ur score" , isPresented: $showScore){
            Button("Continue" , action: askQ)
        } message: {
            Text("ur score = \(score) Round = \(roundNumber)")
            
        }
        
        // MARK: - End Stack
    }
    
    // MARK: - Flag Tapping and scores
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            roundNumber += 1
        } else {
            
            if score > 0{
                roundNumber += 1
                score -= 1
                
            } else {
                restartGame()
                
            }
        }
        showScore = true
        
    }
    // MARK: - Constantly asking questions
    
    func askQ() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    // MARK: - Restart Game
    
    func restartGame() {
        score = 0
        roundNumber = 0
        askQ()
    }
        
}

#Preview {
    ContentView()
}

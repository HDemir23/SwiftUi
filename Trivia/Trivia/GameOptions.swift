//
//  GameOptions.swift
//  Trivia
//
//  Created by Hakan Demir on 2.05.2025.
//
import SwiftUI


struct GameRoute: Hashable {
    let difficultyLevel: String
    let amount: Int
}


struct GameOptions: View {
    @State private var difficultyLevel = "any"
    let difficultyLevels = ["easy", "medium", "hard", "any"]
    @State private var amount: Int = 5
    @State private var path: [GameRoute] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geo in
                VStack {
                    
                    Spacer(minLength: geo.size.height * 0.05)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Section(header: Text("Difficulty")) {
                            Picker("", selection: $difficultyLevel) {
                                ForEach(difficultyLevels, id: \.self) { level in
                                    Text(level)
                                }
                            }
                            .pickerStyle(.segmented)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .clipped()
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Section(header: Text("Amount Of Questions")) {
                            Picker("", selection: $amount) {
                                ForEach(1..<51, id: \.self) { number in
                                    Text("\(number)").tag(number)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: geo.size.height * 0.2)
                            .clipped()
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        path.append(GameRoute(difficultyLevel: difficultyLevel, amount: amount))
                    }) {
                        Text("Start Game")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundStyle(Color.white)
                            .background(Color.secondary)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: geo.size.height * 0.05)
                }
                .padding(20)
            }
            .navigationTitle("SkiVia")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: GameRoute.self) { route in
                GameView(difficultyLevel: route.difficultyLevel, amount: route.amount)
            }
        }
    }
}


/*
 #Preview {
 GameOptions()
 }
 */

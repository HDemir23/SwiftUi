//
//  ContentView.swift
//  Api's VS me
//
//  Created by Hakan Demir on 5.05.2025.
//

import SwiftUI

struct ContentView: View {
    
    
    
    
    

    @StateObject private var StoicModal = StoicViewModel()
    @StateObject private var FatherModal = FatherJokesViewModal()
    @StateObject private var InsultModal = InsultService()
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                

                // MARK: - Random Breaking Bad Qoutes
                
                NavigationLink("Random Stoic Qoutes"){
                    VStack {
                        if let quote = StoicModal.result?.data {
                            Text("\"\(quote.quote)\"")
                                .font(.title2)
                                .padding()
                            Text("- \(quote.author)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        } else {
                            ProgressView("Loading Stoic Wisdom...")
                        }
                    }
                    .task {
                        if StoicModal.result == nil {
                            await StoicModal.fetchData()
                        }
                    }
                }


                // MARK: - Random Father Jokes
                Spacer()
                NavigationLink("Random Father jokes"){
                    
                    if let jokes = FatherModal.result {
                        Text(jokes.setup)
                        NavigationLink("--->>"){
                            Text(jokes.punchline)
                        }
                    } else {
                        Text(":D")
                    }

                }
                .task {
                    if FatherModal.result == nil {
                        await FatherModal.fetchData()
                    }
                }
                
                // MARK: - Random Insult
                Spacer()
                NavigationLink("Random Music"){
                    if let insult = InsultModal.result {
                        Text(insult.insult)
                    } else {
                        Text("pff")
                    }
                }
                .task {
                    if InsultModal.result == nil {
                        await InsultModal.fetchData()
                    }
                }
                
                // MARK: - Random Quotes
                
                Spacer()
                NavigationLink("Random Quotes"){
                    ForEach(0..<5, id: \.self)
                    {_ in
                        Text("123123")
                    }
                }
                // MARK: - Random Pictures
                Spacer()
                NavigationLink("Random Pictures"){
                    RandomImageView()
                }
                Spacer()
                Spacer()
                
                
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("Random")
            
        }
    }
}

#Preview {
    ContentView()
}




struct RandomImageView: View {
    var body: some View {
        GeometryReader { geo in
            AsyncImage(url: URL(string: "https://pic.re/image")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit() 
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                case .failure:
                    Text("Failed to load image")
                        .frame(width: geo.size.width, height: geo.size.height)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

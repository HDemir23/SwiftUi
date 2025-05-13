//
//  Nav.swift
//  Autopedia
//
//  Created by Hakan Demir on 9.05.2025.
//

import SwiftUI

struct Nav: View {
    
    
    @Environment(\.colorScheme) var colorScheme
    
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        
        appearance.backgroundColor = UIColor(named: "blackTheme")
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    
    var body: some View {
        
        
            
            TabView{
                
        // MARK: - Home
            NavigationStack{
                Home()
                
            }
            .navigationViewStyle(.stack)
            .tabItem{
                Label("Home", systemImage: "house")
            }
                
                
        // MARK: - Cars
            NavigationStack{
                Cars()
            }
            .navigationViewStyle(.stack)
            .tabItem{
                Label("Cars", systemImage: "car")
            }
                        
        // MARK: - Gasoline
            NavigationStack{
                Gasoline()
            }
            .navigationViewStyle(.stack)
            .tabItem{
                Label("Gas", systemImage: "fuelpump")
            }
                        
        // MARK: - Testing
            NavigationStack{
                DocsView()
            }
            .navigationViewStyle(.stack)
            .tabItem{
                Label("Docs", systemImage: "book.closed")
            }
                
            }
            .accentColor(Color("NavText"))
            
            
        }
        
    
}


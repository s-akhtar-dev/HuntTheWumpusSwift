//
//  ContentView.swift
//  HuntTheWumpus
//
//  Created by Sarah Akhtar on 10/22/24.
//

import SwiftUI // Primary UI Development Framework

// Declarative UI syntax
struct ContentView: View {
    // Property Wrapper Variables
    // Protocols: StateObject, State
    @StateObject private var game = WumpusGame()
    @State private var showingGameOverSheet = false

    // UI Structure
    var body: some View {
        // VStack = vertical stack view
        VStack(spacing: 20) {
            if (!game.gameStatus.isGameEnded) {
                // Text Views
                Text(game.gameStatus.message)
                    .font(.headline)
                    .padding()
                Text("Arrows left: \(game.arrowsLeft)")
                    .padding(.bottom)
                
                // Main Game
                GameBoardView(game: game)
                
                // Button
                Button("Reset Game") {
                    game.reset()
                }
                .buttonStyle(.bordered)
                .padding()
            }

            if !game.showFinalState {
                GameControlsView(game: game)
            }
        }
        .padding()
        
        // Showing Different Screens
        .onChange(of: game.gameStatus) {
            if game.gameStatus.isGameEnded {
                showingGameOverSheet = true
            }
        }
        .sheet(isPresented: $showingGameOverSheet, onDismiss: {
            game.reset()
        }) {
            GameOverView(game: game)
        }
    }
}

#Preview {
    ContentView()
}

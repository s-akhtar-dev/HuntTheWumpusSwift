//
//  ContentView.swift
//  HuntTheWumpus
//
//  Created by Sarah Akhtar on 10/22/24.
//

import SwiftUI //Primary iOS Development Framework

struct ContentView: View {
    @StateObject private var game = WumpusGame()
    @State private var showingGameOverSheet = false

    var body: some View {
        VStack(spacing: 20) {
            if (!game.gameStatus.isGameEnded) {
                Text(game.gameStatus.message)
                    .font(.headline)
                    .padding()
                Text("Arrows left: \(game.arrowsLeft)")
                    .padding(.bottom)
                
                GameBoardView(game: game)
                
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

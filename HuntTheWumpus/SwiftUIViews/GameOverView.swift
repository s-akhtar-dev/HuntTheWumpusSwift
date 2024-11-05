//
//  GameOverView.swift
//  HuntTheWumpus
//
//  Created by Sarah Akhtar on 11/5/24.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var game: WumpusGame

    var body: some View {
        VStack {
            Text(game.gameStatus.message)
                .font(.title)
                .padding()
            
            GameBoardView(game: game)  // Display final board with Wumpus and pits
            
            Text("Tap outside this sheet to restart the game.")
                .font(.subheadline)
                .padding()
        }
    }
}

#Preview {
    GameOverView(game: WumpusGame())
}

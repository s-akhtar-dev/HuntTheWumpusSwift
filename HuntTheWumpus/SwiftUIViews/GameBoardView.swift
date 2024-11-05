//
//  GameBoardView.swift
//  HuntTheWumpus
//
//  Created by Sarah Akhtar on 11/5/24.
//

import SwiftUI

struct GameBoardView: View {
    @ObservedObject var game: WumpusGame
    
    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<game.boardHeight, id: \.self) { y in
                HStack(spacing: 2) {
                    ForEach(0..<game.boardWidth, id: \.self) { x in
                        GameCellView(
                            game: game,
                            position: (x, y)
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    GameOverView(game: WumpusGame())
}

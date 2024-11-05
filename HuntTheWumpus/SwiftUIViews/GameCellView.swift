//
//  GameCellView.swift
//  HuntTheWumpus
//
//  Created by Sarah Akhtar on 11/5/24.
//

import SwiftUI

struct GameCellView: View {
    @ObservedObject var game: WumpusGame
    let position: (x: Int, y: Int)
    
    var body: some View {
        Button(action: {
            if game.isValidMove(to: position) {
                game.move(to: position)
            }
        }) {
            ZStack {
                Rectangle()
                    .fill(cellBackgroundColor)
                    .frame(width: 50, height: 50)
                    .border(Color.gray, width: 1)
                
                cellContent
            }
        }
        .disabled(game.showFinalState)
    }
    
    private var cellBackgroundColor: Color {
        if game.showFinalState {
            return .blue.opacity(0.1)
        }
        return game.isValidMove(to: position) ?
            Color.green.opacity(0.3) :
            Color.blue.opacity(0.3)
    }
    
    @ViewBuilder
    private var cellContent: some View {
        if game.playerPosition == position {
            Image(systemName: "figure.run")
                .foregroundColor(.black)
        } else if game.showFinalState {
            if game.wumpusPosition == position {
                Image(systemName: "w.circle.fill")
                    .foregroundColor(.red)
            } else if game.pitPositions.contains(where: { $0 == position }) {
                Image(systemName: "wind.circle.fill")
                    .foregroundColor(.brown)
            }
        }
    }
}

#Preview {
    GameCellView(game: WumpusGame(), position: (0, 3))
}

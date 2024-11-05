//
//  GameControlsView.swift
//  HuntTheWumpus
//
//  Created by Sarah Akhtar on 11/5/24.
//

import SwiftUI

struct GameControlsView: View {
    @ObservedObject var game: WumpusGame
    
    var body: some View {
        VStack(spacing: 20) {
            DirectionalControlsView(
                title: "Move",
                onAction: game.move
            )
            
            DirectionalControlsView(
                title: "Shoot Arrow",
                onAction: game.shootArrow
            )
        }
    }
}

#Preview {
    GameControlsView(game: WumpusGame())
}

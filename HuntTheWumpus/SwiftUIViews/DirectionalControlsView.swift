//
//  DirectionalControlsView.swift
//  HuntTheWumpus
//
//  Created by Sarah Akhtar on 11/5/24.
//

import SwiftUI

struct DirectionalControlsView: View {
    let title: String
    let onAction: (Direction) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.subheadline)
            
            HStack(spacing: 15) {
                ForEach([
                    ("←", Direction.left),
                    ("↑", Direction.up),
                    ("↓", Direction.down),
                    ("→", Direction.right)
                ], id: \.0) { arrow, direction in
                    Button(arrow) {
                        onAction(direction)
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    DirectionalControlsView(title: "Shoot an Arrow", onAction: WumpusGame.shootArrow(WumpusGame()))
}

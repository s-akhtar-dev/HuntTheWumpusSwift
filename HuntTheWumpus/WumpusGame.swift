//
//  WumpusGame.swift
//  HuntTheWumpus
//
//  Created by Sarah Akhtar on 10/25/24.
//

import Foundation //the 'iostream' of Swift

/*----------------------------------------*/

// Classic Enumeration for Directions
enum Direction {
    case up, down, left, right
}

/*----------------------------------------*/

// 1. Enum with Associated Values
enum GameStatus: Equatable {
    case playing, wumpusNearby, pitNearby, victory
    case gameOver(String) // Associated value
    
    ///Variables w/ Cases for Message
    var message: String {
        switch self {
            case .playing: return "Hunt the Wumpus!"
            case .wumpusNearby: return "You smell a stench..."
            case .pitNearby: return "You feel a breeze..."
            case .gameOver(let message): return message
            case .victory: return "You slayed the Wumpus! You win!"
        }
    }
    
    ///Variable for Winning State
    var isGameEnded: Bool {
        switch self {
            case .gameOver, .victory: return true
            default: return false
        }
    }
}

/*----------------------------------------*/

// 2. Protocol-Oriented Programming
protocol GameControls {
    func reset()
    func isValidMove(to position: (x: Int, y: Int)) -> Bool
    func move(to position: (x: Int, y: Int))
    func move(direction: Direction)
    func shootArrow(direction: Direction)
    func moveArrow(_ position: inout (x: Int, y: Int), direction: Direction)
    func handleWumpusHit()
    func handleMissedShot()
    func updateGameStatus()
    func isAdjacentToWumpus() -> Bool
    func isAdjacentToPit() -> Bool
}

/*----------------------------------------*/

// 3. Classes and Property Observers in Swift
class WumpusGame: GameControls, ObservableObject {
    ///Published Variables:
    ///Any changes made to these variables will update the entire app
    ///(set) allows for motifying the variable, otherwise constant
    @Published private(set) var playerPosition: (x: Int, y: Int)
    @Published private(set) var gameStatus: GameStatus = .playing
    @Published private(set) var arrowsLeft: Int = 1
    @Published private(set) var showFinalState: Bool = false
    private(set) var wumpusPosition: (x: Int, y: Int)
    private(set) var pitPositions: [(x: Int, y: Int)]
    
    // 4. Type Safety and Inference
    let boardWidth: Int = 6    // Type annotation
    let boardHeight = 4        // Type inference
    
    ///init() is the constructor for Swift
    init() {
        ///Wumpus position: not in first column (x=0) or last row (y=3)
        self.playerPosition = (x: 0, y: 3)
        self.wumpusPosition = (
            x: Int.random(in: 1..<6),
            y: Int.random(in: 0..<3)
        )
        ///Pit positions: not in first column (x=0) or last row (y=3)
        self.pitPositions = (0..<4).map { _ in (
            x: Int.random(in: 1..<6),
            y: Int.random(in: 0..<3)
        )}
    }
    
    // Resets data for new game
    func reset() {
        playerPosition = (x: 0, y: 3)
        wumpusPosition = (
            x: Int.random(in: 1..<6),
            y: Int.random(in: 0..<3)
        )
        pitPositions = (0..<4).map { _ in (
            x: Int.random(in: 1..<6),
            y: Int.random(in: 0..<3)
        )}
        gameStatus = .playing
        arrowsLeft = 1
        showFinalState = false
    }
    
    // Checks for valid move using position tuple
    func isValidMove(to position: (x: Int, y: Int)) -> Bool {
        let dx = abs(playerPosition.x - position.x)
        let dy = abs(playerPosition.y - position.y)
        return (dx == 1 && dy == 0) || (dx == 0 && dy == 1)
    }
    
    // Moves player position from position tuple
    func move(to position: (x: Int, y: Int)) {
        ///guard is the same as using an if statement
        guard isValidMove(to: position) else { return }
        playerPosition = position
        updateGameStatus()
    }
    
    // Moves player position from direction tuple
    func move(direction: Direction) {
        var newPosition = playerPosition
        ///switch statement for moving player based on direction
        switch direction {
        case .up: guard playerPosition.y > 0 else { return }
            newPosition.y -= 1
        case .down: guard playerPosition.y < boardHeight - 1 else { return }
            newPosition.y += 1
        case .left: guard playerPosition.x > 0 else { return }
            newPosition.x -= 1
        case .right: guard playerPosition.x < boardWidth - 1 else { return }
            newPosition.x += 1
        }
        move(to: newPosition)
    }
    
    // Shooting arrow mechanism
    func shootArrow(direction: Direction) {
        guard arrowsLeft > 0 else { return }
        var arrowPosition = playerPosition
        ///underscore means the loop does not pass a list of data to traverse
        for _ in 0..<3 {
            moveArrow(&arrowPosition, direction: direction)
            if arrowPosition == wumpusPosition {
                handleWumpusHit()
                return
            }
        }
        handleMissedShot()
    }

    // Updates position from shooting arrow
    func moveArrow(_ position: inout (x: Int, y: Int), direction: Direction) {
        switch direction {
        case .up: position.y = max(0, position.y - 1)
        case .down: position.y = min(boardHeight - 1, position.y + 1)
        case .left: position.x = max(0, position.x - 1)
        case .right: position.x = min(boardWidth - 1, position.x + 1)
        }
    }

    // Sets game state when hitting wumpus
    func handleWumpusHit() {
        arrowsLeft -= 1
        gameStatus = .victory
        showFinalState = true
    }

    // Handling missed show for wumpus
    func handleMissedShot() {
        arrowsLeft -= 1
        if arrowsLeft == 0 {
            gameStatus = .gameOver("You're out of arrows! Game over!")
            showFinalState = true
        } else {
            gameStatus = .playing
            updateGameStatus()
        }
    }
    
    // Updating GameState Enumeration from Move
    internal func updateGameStatus() {
        if (playerPosition == wumpusPosition) {
            gameStatus = .gameOver("The Wumpus got you! Game over!")
            showFinalState.toggle()
        } else if pitPositions.contains(where: { $0 == playerPosition }) {
            gameStatus = .gameOver("You fell into a pit! Game over!")
            showFinalState.toggle()
        } else if isAdjacentToWumpus() { gameStatus = .wumpusNearby
        } else if isAdjacentToPit() { gameStatus = .pitNearby
        } else { gameStatus = .playing
        }
    }
    
    // Checks for Adjacent Wumpus
    internal func isAdjacentToWumpus() -> Bool {
        let x = abs(playerPosition.x - wumpusPosition.x)
        let y = abs(playerPosition.y - wumpusPosition.y)
        return (x == 1 && y == 0) || (x == 0 && y == 1)
    }
    
    // Checks for Adjacent Pit
    internal func isAdjacentToPit() -> Bool {
        pitPositions.contains { pit in
            let x = abs(playerPosition.x - pit.x)
            let y = abs(playerPosition.y - pit.y)
            return (x == 1 && y == 0) || (x == 0 && y == 1)
        }
    }
}

/*----------------------------------------*/

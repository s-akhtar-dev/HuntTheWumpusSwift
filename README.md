# Hunt The Wumpus in Swift

This project was created for COMP 141 Programming Languages as a coding demonstration for my Swift Final Project Presentation. The code in this repository was developed originally by myself to demonstrate the practical usage of Swift code. The `WumpusGame.swift` file contains the Swift code that pertains the to presentation. The remaining files (`ContentView.swift`, `DirectionalControlView.swift`, etc.) make use of the SwiftUI framework, which are out of scope for this presentation on Swift.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Gameplay](#gameplay)
- [License](#license)

## Features

- Native iOS interface for easy interaction on iOS devices.
- Randomly generated cave layouts for gameplay experience.
- Basic state save method for determining states in game.

## Installation

To get started with the **Hunt The Wumpus** game, follow these steps:

1. Clone the repository:
   ```bash
   git clone git@github.com:s-akhtar-dev/HuntTheWumpusSwift.git
   ```

2. Navigate to the project directory:
   ```bash
   cd HuntTheWumpusSwift
   ```

3. Open the project in Xcode or your preferred Swift IDE.

## Usage

To run the game, execute the main Swift file in your IDE. Follow the on-screen instructions to start playing.

## Gameplay

In **Hunt The Wumpus**, the goal is to find and shoot the Wumpus while avoiding hazards like pits. There will be a maximum of 4 pits in each level, but some may spawn on top of each other. There will be one wumpus per game.

### Basic Commands:

- Move between coordinates on the map (tap or buttons).
- Shoot arrows to defeat the Wumpus (only one shot is allowed).
- Watch for hints that indicate nearby dangers (updated on top).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# Snake Game - x86-64 Assembly Implementation

A classic Snake game implementation written in x86-64 assembly language as part of BTH Masters Programme Coursework for Programming in Unix.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Game Controls](#game-controls)
- [Architecture](#architecture)
- [File Structure](#file-structure)
- [Implementation Details](#implementation-details)
- [Author](#authors)

## 🎮 Overview

This project is a fully functional Snake game implemented primarily in x86-64 assembly language. The game features a configurable snake length and apple count, collision detection, boundary checking, and enhanced gameplay mechanics including speed increases and timer-based challenges.

The implementation demonstrates low-level programming concepts, assembly language proficiency, and integration between C and assembly code using the System V AMD64 ABI calling convention.

## ✨ Features

### Core Features
- **Configurable Gameplay**: Start with custom snake length and number of apples
- **Classic Snake Mechanics**: Snake grows when eating apples, dies on collision
- **Arrow Key Controls**: Smooth directional control with momentum
- **Boundary Collision**: Game ends when snake hits walls
- **Self-Collision Detection**: Game ends when snake hits itself
- **Random Apple Placement**: Apples appear at random valid positions

### Enhanced Features
- **Progressive Speed Increase**: Snake speed increases after eating apples
- **Timer Challenge**: Game ends after a time limit (resets when eating apples)
- **Smart Apple Placement**: Apples only appear in unoccupied spaces
- **Real-time Score Display**: Live score and timer updates
- **Assembly-optimized Helpers**: Core helper functions implemented in assembly

## 🛠 Prerequisites

- **Operating System**: Linux/Unix-based system
- **Compiler**: GNU GCC
- **Assembler**: GNU Assembler (gas)
- **Libraries**: ncurses development libraries
- **Build Tool**: Make

### Installing Dependencies

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install build-essential libncurses5-dev libncurses5
```

**CentOS/RHEL/Fedora:**
```bash
sudo yum install gcc make ncurses-devel
# or for newer versions
sudo dnf install gcc make ncurses-devel
```

## 🔧 Installation

1. **Navigate to the project directory:**
   ```bash
   cd "Assignment 3"
   ```

2. **Build the project:**
   ```bash
   make
   ```
   This creates the executable in the `build/` directory.

3. **Install executable to root directory (optional):**
   ```bash
   make install
   ```
   This copies the executable to the root directory for convenience.

4. **Clean build artifacts:**
   ```bash
   make clean
   ```

5. **Rebuild everything:**
   ```bash
   make rebuild
   ```

## 🚀 Usage

### Basic Usage
```bash
# If you ran 'make install'
./snake <SNAKE_LENGTH> <NUMBER_OF_APPLES>

# Or run directly from build directory
./build/snake <SNAKE_LENGTH> <NUMBER_OF_APPLES>
```

### Examples
```bash
# Start with snake length 5 and 2 apples
./snake 5 2

# Start with snake length 10 and 3 apples
./snake 10 3

# Minimum configuration
./snake 3 1
```

### Parameters
- `SNAKE_LENGTH`: Initial length of the snake (integer > 0)
- `NUMBER_OF_APPLES`: Number of apples on the board simultaneously (integer > 0)

## 🎯 Game Controls

| Key | Action |
|-----|--------|
| ↑ | Move Up |
| ↓ | Move Down |
| ← | Move Left |
| → | Move Right |
| Any other key | Exit game |

### Game Rules
- Snake cannot move backwards (reverse direction)
- Game ends on boundary collision, self-collision, or timer expiration
- Eating apples increases score, snake length, and resets timer
- Snake speed increases progressively with each apple consumed

## 🏗 Architecture

The project follows a hybrid C/Assembly architecture with organized directory structure:

```
┌─────────────────┐    ┌─────────────────┐
│    main.c       │    │   helpers.c     │
│  (Entry Point)  │    │  (C Interface)  │
│     src/        │    │     src/        │
└─────────┬───────┘    └─────────┬───────┘
          │                      │
          │    ┌─────────────────┐│
          └────┤   helpers.h     ││
               │   include/      ││
               └─────────┬───────┘│
                         │        │
                ┌─────────────────┐
                │   Assembly      │
                │  (Game Logic)   │
                │ - snake.asm     │
                │ - start.asm     │
                │     src/        │
                └─────────────────┘
```

## 📁 File Structure

```
Assignment 3/
├── README.md                          # Project documentation
├── Makefile                           # Enhanced build configuration
├── src/                              # Source code directory
│   ├── main.c                        # Entry point and argument parsing
│   ├── helpers.c                     # C helper functions for ncurses
│   ├── snake.asm                     # Main game logic in assembly
│   └── start.asm                     # Game initialization in assembly
├── include/                          # Header files directory
│   └── helpers.h                     # Function declarations and constants
├── build/                           # Build artifacts (auto-generated)
│   ├── snake                        # Compiled executable
│   ├── *.o                         # Object files
│   └── [other build artifacts]
├── docs/                           # Documentation and requirements
│   └── Assignment 3 Requirements.pdf  # Original assignment specification
└── assets/                         # Assets directory (reserved for future use)
```

## 🔍 Implementation Details

### Core Functions (Assembly)

| Function | Purpose |
|----------|---------|
| `snake_touching` | Checks for self-collision detection |
| `remove_tail` | Erases the last segment during movement |
| `draw_snake` | Renders snake on the game board |
| `move_snake_direct` | Updates snake position based on direction |
| `check_boundaries` | Handles boundary and apple collision |
| `snake_mov_keys` | Processes user input for direction changes |
| `draw_board` | Renders game boundaries |
| `place_apple` | Places apples at random valid positions |
| `show_score_lives` | Updates score and timer display |
| `snake_game` | Main game loop orchestration |

### Technical Specifications
- **Assembly Standard**: x86-64 GNU Assembler syntax
- **Calling Convention**: System V AMD64 ABI
- **Graphics Library**: ncurses for terminal-based rendering
- **Build System**: GNU Make with automatic dependency tracking and organized structure
- **Optimization**: Hand-optimized assembly routines for core game logic

### Memory Management
- Static memory allocation for game state
- Efficient array-based snake position tracking
- Minimal memory footprint suitable for embedded systems

### Build System Features
- **Automated Directory Creation**: Build directory created automatically
- **Dependency Tracking**: Automatic recompilation when source files change
- **Clean Builds**: Complete cleanup of all build artifacts
- **Install System**: Optional installation to root directory
- **Rebuild Target**: Complete clean and rebuild in one command


## 👤 Author

**Sohan Arun**  
Master’s Student, Computer Science  
Blekinge Institute of Technology, Sweden  
📧 [Sohanoffice46@gmail.com](mailto:Sohanoffice46@gmail.com)

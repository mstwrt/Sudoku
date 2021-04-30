//
//  BoardBrain.swift
//  Sudoku
//
//  Created by Marcus on 2021-04-09.
// solver, validator, finder functions implemented from Tim Ruscica python code

//

import Foundation

struct Board {
    //9X9 board
    //0 = empty space
    var solvedBoard: [[Int]] = [[0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
    var gameBoard: [[Int]] = [[0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                              [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                              [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
    //difficulty: practice, Very Easy, Easy, Mdium, Hard, Very Hard, Insane
    var difficulty = "Practice"
    var numberOfErrorsAllowed = 0
    
    //getters
    public func getBoard() -> [[Int]] {
        return solvedBoard
    }
    public func getSpace(space: (Int,Int)) -> String {
        return String(gameBoard[space.0][space.1])
    }
    public func getNumberOfErrorsAllowed() -> Int {
        return numberOfErrorsAllowed
    }
    public mutating func getErrorsLeft() -> String {
        numberOfErrorsAllowed -= 1
        return "Errors Left: \(numberOfErrorsAllowed)"

    }
    
    //setters
    public mutating func setDifficulty(diff: String) {
        difficulty = diff
        switch difficulty {
        case "Practice":
            numberOfErrorsAllowed = 10
        case "Very Easy":
            numberOfErrorsAllowed = 5
        case "Easy":
            numberOfErrorsAllowed = 10
        case "Medium":
            numberOfErrorsAllowed = 15
        case "Hard":
            numberOfErrorsAllowed = 20
        case "Very Hard":
            numberOfErrorsAllowed = 25
        case "Master":
            numberOfErrorsAllowed = 30
        case "Insane":
            numberOfErrorsAllowed = 40
        default:
            numberOfErrorsAllowed = 10
        }
    }
    public mutating func updateGameBoard(updateSpace: (Int, Int), newValue: Int) {
        gameBoard[updateSpace.0][updateSpace.1] = newValue
    }

    
    public mutating func startSudoku() {
        //set solved board to zero
        solvedBoard = [[0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
        //make first random row on solved board
        makeFirstRow()
        
        generateBoard()

        
    }
    
    public func checkBoardFinished() -> Bool {
        if gameBoard == solvedBoard {
            return true
        }
        else {
            return false
        }
    }
    
    public func checkErrorsLeft() -> Bool {
        if numberOfErrorsAllowed <= 0 {
            return false
        }
        else {
            return true
        }
    }
    
    public func checkEndGame() -> Bool {
        if gameBoard == solvedBoard {
            return true
        }
        else if numberOfErrorsAllowed <= 0 {
            return true
        }
        else {
            return false
        }
    }
    
    private func findEmptySpace() -> (Int, Int){
        for i in 0 ... solvedBoard.count-1 {
            for j in 0...8 {
                if solvedBoard[i][j] == 0 {
                    return (i,j)
                }
                
            }//end for j
        }//end for i
        
        //no empty spaces
        return (-1,-1)
    }//end findempty
    
    //enerate a random first row
    private mutating func makeFirstRow() {
        let randomStartRow = Int.random(max: 8)
        
        let startNumbers = [1,2,3,4,5,6,7,8,9].shuffled()
        for col in 0...8 {
            solvedBoard[randomStartRow][col] = startNumbers[col]
        }
    
    }
    private mutating func generateBoard() -> Bool {
        var emptySpace: (Int,Int)
        
        //find empty space
        emptySpace = findEmptySpace()
        //non empty space
        if emptySpace == (-1,-1) {
            gameBoard = solvedBoard
            createGameBoard()
            return true
        }
        else {
            //check possible numbers
            
            
            for i in [1,2,3,4,5,6,7,8,9].shuffled() {
                if validateSpace(space: emptySpace, number: i) {
                    solvedBoard[emptySpace.0][emptySpace.1] = i
                    
                    //recursive slove
                    if generateBoard() {
                        return true
                    }//end recursive
                    //notvalid reset space to 0
                    solvedBoard[emptySpace.0][emptySpace.1] = 0
                }//end if validate
            }//end for loop check possible numbers
        }//end else loop
        return false
    }//end solvevboard

    public func checkAnswer(checkSpace: (Int,Int), value: Int) -> Bool {
        if solvedBoard[checkSpace.0][checkSpace.1] == value {
            return true
        }
        else {
            return false
        }
    }
    private func validateSpace(space: (Int,Int), number:Int) -> Bool {
        //check row
        for i in 0...solvedBoard.count-1 {
            if (solvedBoard[space.0][i] == number && space.1 != i) {
                return false
            }
        }//end for loop row
        
        //check col
        for i in 0...solvedBoard.count-1 {
            if (solvedBoard[i][space.1] == number && space.0 != i) {
                return false
            }
        }//end check col for loop
        
        //check box
        let row = space.0/3
        let col = space.1/3
        
        for i in (row*3)...row*3+2  {
            for j in (col*3) ... (col*3+2) {
                if (solvedBoard[i][j] == number && (i,j) != space) {
                    return false
                }
            }
        }
        
        return true
    }//end valid
    
    
    private mutating func createGameBoard() {
        var numberspacesRemove = 0
        switch difficulty {
        case "Practice":
            numberspacesRemove = 15
        case "Very Easy":
            numberspacesRemove = 20
        case "Easy":
            numberspacesRemove = 24
        case "Medium":
            numberspacesRemove = 34
        case "Hard":
            numberspacesRemove = 44
        case "Very Hard":
            numberspacesRemove = 54
        case "Master":
            numberspacesRemove = 64
        case "Insane":
            numberspacesRemove = 66
        default:
            numberspacesRemove = 34
        }
        
        
        
        while numberspacesRemove > 0 {
            let row = Int.random(max: 8)
            let col = Int.random(max: 8)
            
            if gameBoard[row][col] != 0 {
                gameBoard[row][col] = 0
                numberspacesRemove -= 1
            }
            
        }//end while
        
    }//end creategameboard
    
    

}//end brain

extension Int {
    static func random(max: Int) -> Int {
        let rnd = Int(arc4random_uniform(UInt32(max) + 1))
        return rnd
    }
}


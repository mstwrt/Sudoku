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
    //difficulty: practice, VeryEasy, Easy, Mdium, Hard, VeryHard, Insane
    var difficulty = "Easy"
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
    
    //setters
    public mutating func setDifficulty(diff: String) {
        difficulty = diff
        switch difficulty {
        case "Practice":
            numberOfErrorsAllowed = 1
        case "Very Easy":
            numberOfErrorsAllowed = 3
        case "Easy":
            numberOfErrorsAllowed = 4
        case "Medium":
            numberOfErrorsAllowed = 5
        case "Hard":
            numberOfErrorsAllowed = 7
        case "Very Hard":
            numberOfErrorsAllowed = 9
        case "Master":
            numberOfErrorsAllowed = 11
        case "Insane":
            numberOfErrorsAllowed = 13
        default:
            numberOfErrorsAllowed = 4
        }
    }

    
    public mutating func startSudoku() {
        solvedBoard = [[0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
        generateBoard()
        printBoard()
        
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
    
    public func printBoard() {
        print(solvedBoard)
    }
    
    public mutating func getErrorsLeft() -> String {
        
        return "Errors Left: \(numberOfErrorsAllowed)"
        numberOfErrorsAllowed -= 1
    }
    
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
            var row = Int.random(max: 8)
            var col = Int.random(max: 8)
            
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


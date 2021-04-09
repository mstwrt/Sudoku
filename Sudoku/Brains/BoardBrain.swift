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
    var board: [[Int]] = [[0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
    //difficulty: practice, VeryEasy, Easy, Mdium, Hard, VeryHard, Insane
    var difficulty = "Easy"
    
    //getters
    public func getBoard() -> [[Int]] {
        return board
    }
    
    //setters
    public mutating func setDifficulty(diff: String) {
        difficulty = diff
    }
    
    public mutating func startSudoku() {
        generateBoard()
        printBoard()
        board = [[0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0]]
    }
    
    private func findEmptySpace() -> (Int, Int){
        for i in 0 ... board.count-1 {
            for j in 0...8 {
                if board[i][j] == 0 {
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
            return true
        }
        else {
            //check possible numbers
            for i in [1,2,3,4,5,6,7,8,9].shuffled() {
                if validateSpace(space: emptySpace, number: i) {
                    board[emptySpace.0][emptySpace.1] = i
                    
                    //recursive slove
                    if generateBoard() {
                        return true
                    }//end recursive
                    //notvalid reset space to 0
                    board[emptySpace.0][emptySpace.1] = 0
                }//end if validate
            }//end for loop check possible numbers
        }//end else loop
        return false
    }//end solvevboard

    private func validateSpace(space: (Int,Int), number:Int) -> Bool {
        //check row
        for i in 0...board.count-1 {
            if (board[space.0][i] == number && space.1 != i) {
                return false
            }
        }//end for loop row
        
        //check col
        for i in 0...board.count-1 {
            if (board[i][space.1] == number && space.0 != i) {
                return false
            }
        }//end check col for loop
        
        //check box
        let row = space.0/3
        let col = space.1/3
        
        for i in (row*3)...row*3+2  {
            for j in (col*3) ... (col*3+2) {
                if (board[i][j] == number && (i,j) != space) {
                    return false
                }
            }
        }
        
        return true
    }//end valid
    
    public func printBoard() {
        print(board)
    }
    
    

}//end brain

extension Int {
    static func random(max: Int) -> Int {
        let rnd = Int(arc4random_uniform(UInt32(max) + 1))
        return rnd
    }
}


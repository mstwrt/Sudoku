//
//  BoardBrain.swift
//  Sudoku
//
//  Created by Marcus on 2021-04-09.
// solver, validator, finder functions implemented from Tim Ruscica python code

//

import Foundation

struct Board {
    //4X4 board
    //0 = empty space
    var board: [[Int]] = [[1,2,3,0,0,0,0,0,0], [4,5,6,0,0,0,0,0,0],[7,8,9,0,0,0,0,0,0],
                          [0,0,0,1,2,3,0,0,0], [0,0,0,4,5,6,0,0,0],[0,0,0,7,8,9,0,0,0],
                          [0,0,0,0,0,0,1,2,3], [0,0,0,0,0,0,4,5,6],[0,0,0,0,0,0,7,8,9]]

    private func findEmptySpace() -> (Int, Int){
        print(board.count)
        for i in 0...8 {
            for j in 0...8 {
                if board[i][j] == 0 {
                    return (i,j)
                }
                
            }//end for j
        }//end for i
        
        //no empty spaces
        return (-1,-1)
    }//end findempty
    
    public mutating func solveBoard() -> Bool {
        var emptySpace: (Int,Int)
        //find empty space
        emptySpace = findEmptySpace()
        //non empty space
        if emptySpace == (-1,-1) {
            return true
        }
        else {
            //check possible numbers
            for i in 1...9 {
                if validateSpace(space: emptySpace, number: i) {
                    board[emptySpace.0][emptySpace.1] = i
                    
                    //recursive slove
                    if solveBoard() {
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
        for i in 0...8 {
            if (board[space.0][i] == number && space.1 != i) {
                return false
            }
        }//end for loop row
        
        //check col
        for i in 0...8 {
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


//
//  ViewController.swift
//  Sudoku
//
//  Created by Marcus on 2021-04-09.
//sudoku grid from sudoku primier
//

import UIKit

class ViewController: UIViewController {
    private var currentGridLocation: (Int, Int)!
    private var gridButtonIndex: Int = -1
    private var oldGridButtonIndex: Int = -1
    private var boardManager = Board()
    public var difficulty: String = ""
    
    
    @IBOutlet weak var errorsLeftLabel: UILabel!
    @IBOutlet var gridButtons: [UIButton]!
    
    
    @IBAction func diffButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "mainToDiff", sender: self)
    }
    @IBAction func gridButtonPushed(_ sender: UIButton) {
        //check end game
        if !boardManager.checkEndGame() {
            if sender.tag == 0 {
                //if no previous gridbutton selected
                if gridButtonIndex == -1 {
                    gridButtonIndex = gridButtons.firstIndex(of: sender) ?? -1
                    readyButtonToSet(newButton: sender)
                }
                //a gridbutton has been selected, but not changed
                else {
                    oldGridButtonIndex = gridButtonIndex
                    gridButtonIndex = gridButtons.firstIndex(of: sender) ?? -1
                    //clear old gridbutton selected
                    clearButtonToSet()
                    readyButtonToSet(newButton: sender)
                } //end grid button was previously selected
            } //end sender tag
        } //end check end game
    }//end grid button pushed
    
    @IBAction func numberButtonPushed(_ sender: UIButton) {
        var row = 0
        var col = 0
        //check if a grid button has been selected
        if gridButtonIndex != -1 {
            //set row and col of grid
            row = gridButtonIndex/9
            if (gridButtonIndex % 9) > 0 {
                col = gridButtonIndex % 9
            }
            else {
                col = 0
            }
            //set gridbutton title and title color, reset index
            if boardManager.checkAnswer(checkSpace: (row, col), value: sender.tag) {
                gridButtons[gridButtonIndex].setTitle(sender.currentTitle, for: .normal)
                gridButtons[gridButtonIndex].setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                gridButtons[gridButtonIndex].tag = 1
                gridButtonIndex = -1
                if boardManager.checkBoardFinished() {
                    errorsLeftLabel.text = "Yay! You Got It!"
                }
            }
            //not a valid spot for that number
            else {
                //update trys left
                errorsLeftLabel.text = boardManager.getErrorsLeft()
                if !boardManager.checkErrorsLeft() {
                    errorsLeftLabel.text = "Game Over! No More Tries"
                }
            }
        }//end check gridbutton index
    }//end number buttonpushed func
    
    @IBAction func startButtonPushed(_ sender: UIButton) {
        boardManager.setDifficulty(diff: difficulty)
        boardManager.startSudoku()
        fillGrid()
        errorsLeftLabel.text = "Tries Left \(String(boardManager.getNumberOfErrorsAllowed()))"
        gridButtonIndex = -1
        
        
    }
    
    private func readyButtonToSet(newButton: UIButton) {
        gridButtons[gridButtonIndex].setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: .normal)
        gridButtons[gridButtonIndex].setTitle("?", for: .normal)
    }
    
    private func clearButtonToSet() {
        gridButtons[oldGridButtonIndex].setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        gridButtons[oldGridButtonIndex].setTitle("", for: .normal)
        oldGridButtonIndex = -1
    }
    
    private func fillGrid() {
        //fill grid
        for i in 0 ... 8 {
            gridButtons[i].setTitle(boardManager.getSpace(space: (0,i)), for: .normal)
            gridButtons[i+9].setTitle(boardManager.getSpace(space: (1,i)), for: .normal)
            gridButtons[i+18].setTitle(boardManager.getSpace(space: (2,i)), for: .normal)
            gridButtons[i+27].setTitle(boardManager.getSpace(space: (3,i)), for: .normal)
            gridButtons[i+36].setTitle(boardManager.getSpace(space: (4,i)), for: .normal)
            gridButtons[i+45].setTitle(boardManager.getSpace(space: (5,i)), for: .normal)
            gridButtons[i+54].setTitle(boardManager.getSpace(space: (6,i)), for: .normal)
            gridButtons[i+63].setTitle(boardManager.getSpace(space: (7,i)), for: .normal)
            gridButtons[i+72].setTitle(boardManager.getSpace(space: (8,i)), for: .normal)
        }
        for i in 0 ... gridButtons.count-1 {
            //buttonToSet = nil
            gridButtons[i].tag = 1
            gridButtons[i].setTitleColor(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), for: .normal)
            if gridButtons[i].currentTitle == "0" {
                gridButtons[i].setTitle("", for: .normal)
                gridButtons[i].tag = 0
            }
        }//end loop setting gridbuttons to 0
    }//end fill grid func
    
    //overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        boardManager.setDifficulty(diff: difficulty)
        boardManager.startSudoku()
        fillGrid()
        errorsLeftLabel.text = "Tries Left \(String(boardManager.getNumberOfErrorsAllowed()))"
    }
}//end claa


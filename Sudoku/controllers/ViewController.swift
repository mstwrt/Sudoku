//
//  ViewController.swift
//  Sudoku
//
//  Created by Marcus on 2021-04-09.
//sudoku grid from sudoku primier
//

import UIKit

class ViewController: UIViewController {
    //@IBOutlet var displayRows: [UILabel]!
    //@IBOutlet var test: [UILabel]!
    //var buttonToSet: UIButton!
    var currentGridLocation: (Int, Int)!
    var gridButtonIndex: Int = -1
    var oldGridButtonIndex: Int = -1
    
    @IBOutlet weak var errorsLeftLabel: UILabel!
    @IBOutlet var gridButtons: [UIButton]!
    
    @IBAction func gridButtonPushed(_ sender: UIButton) {
        if sender.tag == 0 {
            //if no previous gridbutton selected
            if gridButtonIndex == -1 {
                //buttonToSet = sender
                gridButtonIndex = gridButtons.firstIndex(of: sender) ?? -1
                readyButtonToSet(newButton: sender)
                if (gridButtonIndex % 9) > 0 {
                    print(gridButtonIndex/9)
                    print(gridButtonIndex%9)
                }
                else {
                    print(gridButtonIndex/9)
                    print("0")
                }
                
                
            }
            //a gridbutton has been selected, but not changed
            else {
                
                oldGridButtonIndex = gridButtonIndex
                gridButtonIndex = gridButtons.firstIndex(of: sender) ?? -1
                //clear old gridbutton selected
                clearButtonToSet()
                readyButtonToSet(newButton: sender)
                if (gridButtonIndex % 9) > 0 {
                    print(gridButtonIndex/9)
                    print(gridButtonIndex%9)
                }
                else {
                    print(gridButtonIndex/9)
                    print("0")
                }
            }
        }
    }
    
    @IBAction func numberButtonPushed(_ sender: UIButton) {
        var row = 0
        var col = 0
        if gridButtonIndex != -1 {
            row = gridButtonIndex/9
            if (gridButtonIndex % 9) > 0 {
                col = gridButtonIndex % 9
            }
            else {
                col = 0
            }
            //buttonToSet.setTitle(sender.currentTitle, for: .normal)
            //buttonToSet.tag = 1
            print("Row: \(row) Col: \(col)")
            print(boardManager.checkAnswer(checkSpace: (row,col), value: sender.tag))
            if boardManager.checkAnswer(checkSpace: (row, col), value: sender.tag) {
                gridButtons[gridButtonIndex].setTitle(sender.currentTitle, for: .normal)
                gridButtons[gridButtonIndex].setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                gridButtons[gridButtonIndex].tag = 1
                gridButtonIndex = -1
            }
            else {
                errorsLeftLabel.text = boardManager.getErrorsLeft()
                
            }
            
        }
    }
    
    
    var boardManager = Board()
    var difficulty: String = ""
    
    
    private func readyButtonToSet(newButton: UIButton) {
        //buttonToSet = newButton
        //buttonToSet.setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: .normal)
        //buttonToSet.setTitle("?", for: .normal)
        
        gridButtons[gridButtonIndex].setTitleColor(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), for: .normal)
        gridButtons[gridButtonIndex].setTitle("?", for: .normal)
        
    }
    
    private func clearButtonToSet() {
        //buttonToSet.setTitle("", for: .normal)
        //buttonToSet.setTitleColor(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), for: .normal)
        //buttonToSet.tag = 0
        gridButtons[oldGridButtonIndex].setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        gridButtons[oldGridButtonIndex].setTitle("", for: .normal)
        oldGridButtonIndex = -1
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(difficulty)
        boardManager.setDifficulty(diff: difficulty)
        boardManager.startSudoku()
        fillGrid()
        errorsLeftLabel.text = "Errors Left \(String(boardManager.getNumberOfErrorsAllowed()))"
        
        
        
    }
    
    @IBAction func startButtonPushed(_ sender: UIButton) {
        boardManager.startSudoku()
        fillGrid()
        
        
    }
    
    private func fillGrid() {
        //fill grid
        for i in 0 ... 8 {
            gridButtons[i].setTitle(boardManager.getSpace(space: (0,i)), for: .normal)
            gridButtons[i+9].setTitle(boardManager.getSpace(space: (1,i)), for: .normal)
            //gridLabelArray[i+9].text = boardManager.getSpace(space: (1,i))
            gridButtons[i+18].setTitle(boardManager.getSpace(space: (2,i)), for: .normal)
            //gridLabelArray[i+18].text = boardManager.getSpace(space: (2,i))
            gridButtons[i+27].setTitle(boardManager.getSpace(space: (3,i)), for: .normal)
            //gridLabelArray[i+27].text = boardManager.getSpace(space: (3,i))
            gridButtons[i+36].setTitle(boardManager.getSpace(space: (4,i)), for: .normal)
            //gridLabelArray[i+36].text = boardManager.getSpace(space: (4,i))
            gridButtons[i+45].setTitle(boardManager.getSpace(space: (5,i)), for: .normal)
            //gridLabelArray[i+45].text = boardManager.getSpace(space: (5,i))
            gridButtons[i+54].setTitle(boardManager.getSpace(space: (6,i)), for: .normal)
            //gridLabelArray[i+54].text = boardManager.getSpace(space: (6,i))
            gridButtons[i+63].setTitle(boardManager.getSpace(space: (7,i)), for: .normal)
            //gridLabelArray[i+63].text = boardManager.getSpace(space: (7,i))
            gridButtons[i+72].setTitle(boardManager.getSpace(space: (8,i)), for: .normal)
            //gridLabelArray[i+72].text = boardManager.getSpace(space: (8,i))
        }
        for i in 0 ... gridButtons.count-1 {
            //buttonToSet = nil
            gridButtons[i].tag = 1
            gridButtons[i].setTitleColor(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), for: .normal)
            if gridButtons[i].currentTitle == "0" {
                gridButtons[i].setTitle("", for: .normal)
                gridButtons[i].tag = 0
            }
        }
    }
    
}


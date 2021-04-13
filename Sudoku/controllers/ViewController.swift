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
    var buttonToSet: UIButton!
    @IBOutlet var gridButtons: [UIButton]!
    
    
    
    
    var boardManager = Board()
    var difficulty: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print(difficulty)
        boardManager.setDifficulty(diff: difficulty)
        boardManager.startSudoku()
        fillGrid()
        
        
        
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
            if gridButtons[i].currentTitle == "0" {
                gridButtons[i].setTitle("", for: .normal)
                gridButtons[i].tag = 0
            }
        }
    }
    
}


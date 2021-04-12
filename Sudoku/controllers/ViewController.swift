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
    @IBOutlet var gridLabelArray: [UILabel]!
    
    
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
            gridLabelArray[i].text = boardManager.getSpace(space: (0,i))
            gridLabelArray[i+9].text = boardManager.getSpace(space: (1,i))
            gridLabelArray[i+18].text = boardManager.getSpace(space: (2,i))
            gridLabelArray[i+27].text = boardManager.getSpace(space: (3,i))
            gridLabelArray[i+36].text = boardManager.getSpace(space: (4,i))
            gridLabelArray[i+45].text = boardManager.getSpace(space: (5,i))
            gridLabelArray[i+54].text = boardManager.getSpace(space: (6,i))
            gridLabelArray[i+63].text = boardManager.getSpace(space: (7,i))
            gridLabelArray[i+72].text = boardManager.getSpace(space: (8,i))
        }
        for i in 0 ... gridLabelArray.count-1 {
            if gridLabelArray[i].text == "0" {
                gridLabelArray[i].text = ""
            }
        }
    }
    
}


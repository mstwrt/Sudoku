//
//  ViewController.swift
//  Sudoku
//
//  Created by Marcus on 2021-04-09.
//

import UIKit

class ViewController: UIViewController {

    var boardManager = Board()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonPushed(_ sender: UIButton) {
        boardManager.startSudoku()
    }
    
}


//
//  DifficultyViewController.swift
//  Sudoku
//
//  Created by Marcus on 2021-04-12.
//

import Foundation
import UIKit

class DifficultyViewController: UIViewController {
    
    var difficulty: String = "SPam Spam Spam HUmbug"
    
    @IBAction func startButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "difficultyToMain", sender: self)
    
    }  //end startbuttonpushed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add additional setup code after load
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "difficultyToMain"
        {
            let destinationVC = segue.destination as! ViewController
            destinationVC.difficulty = difficulty
        }
    }
    
}//end class

